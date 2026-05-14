using Android.Graphics;
using Android.Runtime;
using CleverApp.Services;
using Xamarin.Google.MLKit.Vision.BarCode;
using Xamarin.Google.MLKit.Vision.Barcode.Common;
using Xamarin.Google.MLKit.Vision.Common;
using Xamarin.Google.MLKit.Vision.Text;
using Xamarin.Google.MLKit.Vision.Text.Latin;

namespace CleverApp.Platforms.Android.Services;

/// <summary>PDF417 + OCR через Google ML Kit (только Android).</summary>
/// <remarks>
/// Text Recognition v2 в ML Kit поставляет отдельные модели только для латиницы, китайского,
/// деванагари, японского и корейского. Кириллица с удостоверения распознаётся «как получится»
/// через общий латинский конвейер — для КЗ УЛ опирайтесь на PDF417 и MRZ.
/// </remarks>
public sealed class MlKitIdDocumentScanner : IIdDocumentScanner
{
    public async Task<IdScanResult> ScanAsync(Stream imageStream, System.Threading.CancellationToken cancellationToken = default)
    {
        await using var _ = imageStream.ConfigureAwait(false);

        var bitmap = await BitmapFactory.DecodeStreamAsync(imageStream).ConfigureAwait(false);
        if (bitmap == null)
            return new IdScanResult { Source = "None", OcrText = "Не удалось декодировать изображение." };

        try
        {
            cancellationToken.ThrowIfCancellationRequested();
            var inputImage = InputImage.FromBitmap(bitmap, 0);

            string? pdf417 = await TryDecodePdf417Async(inputImage, cancellationToken).ConfigureAwait(false);

            cancellationToken.ThrowIfCancellationRequested();
            var ocr = await TryRecognizeTextFromBitmapAsync(bitmap, cancellationToken).ConfigureAwait(false);

            var mrzBlock = MrzExtractor.TryFindMrzTd1Block(ocr);
            string? mrzLine = null;
            string? mrzSurname = null;
            string? mrzGiven = null;

            if (!string.IsNullOrWhiteSpace(mrzBlock))
            {
                var lines = mrzBlock.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                mrzLine = lines.Length > 0 ? lines[0] : null;
                if (lines.Length >= 3)
                    (mrzSurname, mrzGiven) = MrzTd1Parser.TryParseLine3(lines[2]);
            }
            else
            {
                mrzLine = MrzExtractor.TryFindMrzLine(ocr);
            }

            var source = !string.IsNullOrWhiteSpace(pdf417) && !string.IsNullOrWhiteSpace(ocr)
                ? "MLKit:PDF417+OCR"
                : !string.IsNullOrWhiteSpace(pdf417)
                    ? "MLKit:PDF417"
                    : !string.IsNullOrWhiteSpace(ocr)
                        ? "MLKit:OCR"
                        : "None";

            return new IdScanResult
            {
                Pdf417Raw = pdf417,
                OcrText = ocr,
                Source = source,
                MrzLine = mrzLine,
                MrzBlock = mrzBlock,
                MrzSurnameLatin = mrzSurname,
                MrzGivenNamesLatin = mrzGiven
            };
        }
        finally
        {
            if (!bitmap.IsRecycled)
                bitmap.Recycle();
        }
    }

    /// <summary>Несколько проходов OCR: исходник, масштаб+контраст (MRZ), оттенки серого+контраст (мелкий текст).</summary>
    private static async Task<string?> TryRecognizeTextFromBitmapAsync(Bitmap bitmap, System.Threading.CancellationToken cancellationToken)
    {
        var best = await RecognizeTextOnceAsync(bitmap, cancellationToken).ConfigureAwait(false);

        Bitmap? enhanced = null;
        Bitmap? grayContrast = null;
        try
        {
            enhanced = CreateEnhancedForOcr(bitmap);
            if (enhanced is not null)
            {
                var secondary = await RecognizeTextOnceAsync(enhanced, cancellationToken).ConfigureAwait(false);
                best = MrzExtractor.PickBetterOcr(best, secondary);
            }

            grayContrast = CreateGrayscaleContrastForOcr(bitmap);
            if (grayContrast is not null)
            {
                var tertiary = await RecognizeTextOnceAsync(grayContrast, cancellationToken).ConfigureAwait(false);
                best = MrzExtractor.PickBetterOcr(best, tertiary);
            }

            return best;
        }
        finally
        {
            if (enhanced is not null && !enhanced.IsRecycled)
                enhanced.Recycle();
            if (grayContrast is not null && !grayContrast.IsRecycled)
                grayContrast.Recycle();
        }
    }

    private static Bitmap? CreateEnhancedForOcr(Bitmap src)
    {
        try
        {
            if (src.Width < 2 || src.Height < 2)
                return null;

            var w = Math.Min(src.Width * 2, 3200);
            var h = Math.Min(src.Height * 2, 3200);
            using var scaled = Bitmap.CreateScaledBitmap(src, w, h, filter: true);
            if (scaled is null)
                return null;

            var matrix = new ColorMatrix(new[]
            {
                1.65f, 0, 0, 0, -35f,
                0, 1.65f, 0, 0, -35f,
                0, 0, 1.65f, 0, -35f,
                0, 0, 0, 1f, 0f
            });

            using var paint = new global::Android.Graphics.Paint();
            paint.SetColorFilter(new ColorMatrixColorFilter(matrix));
            var bmp = Bitmap.CreateBitmap(w, h, Bitmap.Config.Argb8888!);
            using var canvas = new Canvas(bmp);
            canvas.DrawBitmap(scaled, 0, 0, paint);
            return bmp;
        }
        catch
        {
            return null;
        }
    }

    /// <summary>Ч/б с усилением контраста — иногда стабильнее для мелкого латинского текста и MRZ.</summary>
    private static Bitmap? CreateGrayscaleContrastForOcr(Bitmap src)
    {
        try
        {
            if (src.Width < 2 || src.Height < 2)
                return null;

            double scale = 1.0;
            var maxSide = Math.Max(src.Width, src.Height);
            if (maxSide > 2800)
                scale = 2800.0 / maxSide;
            else if (maxSide < 1300)
                scale = Math.Min(2.0, 2600.0 / maxSide);

            var w = Math.Max(1, (int)(src.Width * scale));
            var h = Math.Max(1, (int)(src.Height * scale));
            using var scaled = Bitmap.CreateScaledBitmap(src, w, h, filter: true);
            if (scaled is null)
                return null;

            const float lr = 0.2126f;
            const float lg = 0.7152f;
            const float lb = 0.0722f;
            const float gain = 1.85f;
            const float bias = -38f;

            var matrix = new ColorMatrix(new[]
            {
                lr * gain, lg * gain, lb * gain, 0, bias,
                lr * gain, lg * gain, lb * gain, 0, bias,
                lr * gain, lg * gain, lb * gain, 0, bias,
                0, 0, 0, 1f, 0f
            });

            using var paint = new global::Android.Graphics.Paint();
            paint.SetColorFilter(new ColorMatrixColorFilter(matrix));
            var bmp = Bitmap.CreateBitmap(w, h, Bitmap.Config.Argb8888!);
            using var canvas = new Canvas(bmp);
            canvas.DrawBitmap(scaled, 0, 0, paint);
            return bmp;
        }
        catch
        {
            return null;
        }
    }

    private static async Task<string?> RecognizeTextOnceAsync(Bitmap bitmap, System.Threading.CancellationToken cancellationToken)
    {
        var options = TextRecognizerOptions.DefaultOptions;
        var recognizer = TextRecognition.GetClient(options);
        try
        {
            using var inputImage = InputImage.FromBitmap(bitmap, rotationDegrees: 0);
            var task = recognizer.Process(inputImage);
            var visionText = await AwaitAndroidTaskAsync(task, cancellationToken).ConfigureAwait(false);
            if (visionText is null)
                return null;

            var vt = visionText.JavaCast<global::Xamarin.Google.MLKit.Vision.Text.Text>();
            return vt?.GetText();
        }
        finally
        {
            try
            {
                recognizer.Close();
            }
            catch
            {
                // Close может отсутствовать в части версий биндингов
            }
        }
    }

    private static async Task<string?> TryDecodePdf417Async(InputImage inputImage, System.Threading.CancellationToken cancellationToken)
    {
        var options = new BarcodeScannerOptions.Builder()
            .SetBarcodeFormats(Barcode.FormatPdf417)
            .Build();

        var scanner = BarcodeScanning.GetClient(options);
        var task = scanner.Process(inputImage);
        var result = await AwaitAndroidTaskAsync(task, cancellationToken).ConfigureAwait(false);
        if (result is null)
            return null;

        var list = result.JavaCast<Java.Util.IList>();
        if (list is null)
            return null;

        for (var i = 0; i < list.Size(); i++)
        {
            var item = list.Get(i);
            var barcode = item.JavaCast<Barcode>();
            if (barcode is null)
                continue;
            if (barcode.Format != Barcode.FormatPdf417)
                continue;
            var raw = barcode.RawValue;
            if (!string.IsNullOrWhiteSpace(raw))
                return raw;
        }

        return null;
    }

    private static Task<Java.Lang.Object?> AwaitAndroidTaskAsync(global::Android.Gms.Tasks.Task task, System.Threading.CancellationToken cancellationToken)
    {
        var tcs = new TaskCompletionSource<Java.Lang.Object?>(TaskCreationOptions.RunContinuationsAsynchronously);

        if (cancellationToken.CanBeCanceled)
        {
            cancellationToken.Register(() => tcs.TrySetCanceled(cancellationToken));
        }

        task.AddOnCompleteListener(new TaskCompleteListener(tcs));

        return tcs.Task;
    }

    private sealed class TaskCompleteListener : Java.Lang.Object, global::Android.Gms.Tasks.IOnCompleteListener
    {
        private readonly TaskCompletionSource<Java.Lang.Object?> _tcs;

        public TaskCompleteListener(TaskCompletionSource<Java.Lang.Object?> tcs) => _tcs = tcs;

        public void OnComplete(global::Android.Gms.Tasks.Task task)
        {
            try
            {
                if (task.IsCanceled)
                {
                    _tcs.TrySetCanceled();
                    return;
                }

                if (!task.IsSuccessful)
                {
                    var ex = task.Exception;
                    if (ex != null)
                        _tcs.TrySetException(ex);
                    else
                        _tcs.TrySetException(new InvalidOperationException("ML Kit task failed."));
                    return;
                }

                _tcs.TrySetResult(task.Result);
            }
            catch (Exception ex)
            {
                _tcs.TrySetException(ex);
            }
        }
    }
}
