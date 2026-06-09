using ZXing;
#if ANDROID
using SkiaSharp;
using ZXing.Common;
#else
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using ZXing.Common;
#endif

namespace CleverApp.Services;

internal static class PhotoBarcodeZxing
{
    public static string? DecodeBarcodes(byte[] imageBytes, IList<BarcodeFormat> formats)
    {
#if ANDROID
        using var original = SKBitmap.Decode(imageBytes);
        if (original is null)
            return null;

        const int targetWidth = 1200;
        var targetHeight = Math.Max(400, (int)(original.Height * (targetWidth / (double)original.Width)));
        using var resized = original.Resize(new SKImageInfo(targetWidth, targetHeight), SKFilterQuality.High);
        return resized is null ? null : DecodeBarcodesSkia(resized, formats);
#else
        return DecodeBarcodesImageSharp(imageBytes, formats);
#endif
    }

    public static string? DecodePdf417(byte[] imageBytes)
    {
#if ANDROID
        using var original = SKBitmap.Decode(imageBytes);
        if (original is null)
            return null;

        const int targetWidth = 1200;
        var targetHeight = Math.Max(400, (int)(original.Height * (targetWidth / (double)original.Width)));
        using var resized = original.Resize(new SKImageInfo(targetWidth, targetHeight), SKFilterQuality.High);
        return resized is null ? null : DecodePdf417Skia(resized);
#else
        return DecodePdf417ImageSharp(imageBytes);
#endif
    }

#if ANDROID
    private static string? DecodeBarcodesSkia(SKBitmap bitmap, IList<BarcodeFormat> formats)
    {
        var zones = new[]
        {
            new SKRectI(0, 0, bitmap.Width, bitmap.Height),
            new SKRectI(0, bitmap.Height / 3, bitmap.Width, bitmap.Height * 2 / 3),
            new SKRectI(0, bitmap.Height / 2, bitmap.Width, bitmap.Height)
        };

        return DecodeSkiaZones(bitmap, formats, zones);
    }

    private static string? DecodePdf417Skia(SKBitmap bitmap)
    {
        var zones = new[]
        {
            new SKRectI(0, bitmap.Height / 2, bitmap.Width, bitmap.Height),
            new SKRectI(0, bitmap.Height * 2 / 3, bitmap.Width, bitmap.Height),
            new SKRectI(0, 0, bitmap.Width, bitmap.Height)
        };

        return DecodeSkiaZones(bitmap, new List<BarcodeFormat> { BarcodeFormat.PDF_417 }, zones);
    }

    private static string? DecodeSkiaZones(SKBitmap bitmap, IList<BarcodeFormat> formats, SKRectI[] zones)
    {
        var reader = CreateReader(formats);
        foreach (var zone in zones)
        {
            using var cropped = Crop(bitmap, zone);
            var decoded = DecodeSkia(reader, cropped, invert: false) ?? DecodeSkia(reader, cropped, invert: true);
            if (!string.IsNullOrWhiteSpace(decoded))
                return decoded;
        }

        return null;
    }

    private static SKBitmap Crop(SKBitmap source, SKRectI rect)
    {
        var width = Math.Max(1, rect.Width);
        var height = Math.Max(1, rect.Height);
        var cropped = new SKBitmap(width, height);

        using var canvas = new SKCanvas(cropped);
        canvas.DrawBitmap(
            source,
            new SKRect(rect.Left, rect.Top, rect.Right, rect.Bottom),
            new SKRect(0, 0, width, height));

        return cropped;
    }

    private static string? DecodeSkia(MultiFormatReader reader, SKBitmap bitmap, bool invert)
    {
        try
        {
            var pixels = bitmap.Pixels;
            var rgb = new byte[bitmap.Width * bitmap.Height * 3];

            for (var i = 0; i < pixels.Length; i++)
            {
                var r = pixels[i].Red;
                var g = pixels[i].Green;
                var b = pixels[i].Blue;

                if (invert)
                {
                    r = (byte)(255 - r);
                    g = (byte)(255 - g);
                    b = (byte)(255 - b);
                }

                var offset = i * 3;
                rgb[offset] = r;
                rgb[offset + 1] = g;
                rgb[offset + 2] = b;
            }

            return DecodeRgb(reader, rgb, bitmap.Width, bitmap.Height);
        }
        catch
        {
            return null;
        }
    }
#else
    private static string? DecodeBarcodesImageSharp(byte[] imageBytes, IList<BarcodeFormat> formats)
    {
        using var image = LoadResized(imageBytes);
        var zones = new (int X, int Y, int W, int H)[]
        {
            (0, 0, image.Width, image.Height),
            (0, image.Height / 3, image.Width, image.Height * 2 / 3),
            (0, image.Height / 2, image.Width, image.Height / 2)
        };

        return DecodeImageSharpZones(image, formats, zones);
    }

    private static string? DecodePdf417ImageSharp(byte[] imageBytes)
    {
        using var image = LoadResized(imageBytes);
        var zones = new (int X, int Y, int W, int H)[]
        {
            (0, image.Height / 2, image.Width, image.Height / 2),
            (0, image.Height * 2 / 3, image.Width, image.Height / 3),
            (0, 0, image.Width, image.Height)
        };

        return DecodeImageSharpZones(image, new List<BarcodeFormat> { BarcodeFormat.PDF_417 }, zones);
    }

    private static SixLabors.ImageSharp.Image<Rgb24> LoadResized(byte[] imageBytes)
    {
        var image = SixLabors.ImageSharp.Image.Load<Rgb24>(imageBytes);
        const int targetWidth = 1200;
        var targetHeight = Math.Max(400, (int)(image.Height * (targetWidth / (double)image.Width)));
        image.Mutate(x => x.Resize(targetWidth, targetHeight));
        return image;
    }

    private static string? DecodeImageSharpZones(
        SixLabors.ImageSharp.Image<Rgb24> image,
        IList<BarcodeFormat> formats,
        (int X, int Y, int W, int H)[] zones)
    {
        var reader = CreateReader(formats);
        foreach (var (x, y, w, h) in zones)
        {
            var crop = new SixLabors.ImageSharp.Rectangle(x, y, w, h);
            using var cropped = image.Clone(ctx => ctx.Crop(crop));
            var decoded = DecodeImageSharp(reader, cropped, invert: false) ?? DecodeImageSharp(reader, cropped, invert: true);
            if (!string.IsNullOrWhiteSpace(decoded))
                return decoded;
        }

        return null;
    }

    private static string? DecodeImageSharp(MultiFormatReader reader, SixLabors.ImageSharp.Image<Rgb24> image, bool invert)
    {
        try
        {
            var rgb = new byte[image.Width * image.Height * 3];
            image.ProcessPixelRows(accessor =>
            {
                for (var rowY = 0; rowY < accessor.Height; rowY++)
                {
                    var row = accessor.GetRowSpan(rowY);
                    for (var colX = 0; colX < row.Length; colX++)
                    {
                        ref var pixel = ref row[colX];
                        var r = invert ? (byte)(255 - pixel.R) : pixel.R;
                        var g = invert ? (byte)(255 - pixel.G) : pixel.G;
                        var b = invert ? (byte)(255 - pixel.B) : pixel.B;
                        var offset = (rowY * image.Width + colX) * 3;
                        rgb[offset] = r;
                        rgb[offset + 1] = g;
                        rgb[offset + 2] = b;
                    }
                }
            });

            return DecodeRgb(reader, rgb, image.Width, image.Height);
        }
        catch
        {
            return null;
        }
    }
#endif

    private static MultiFormatReader CreateReader(IList<BarcodeFormat> formats) => new()
    {
        Hints = new Dictionary<DecodeHintType, object>
        {
            { DecodeHintType.POSSIBLE_FORMATS, formats },
            { DecodeHintType.TRY_HARDER, true },
            { DecodeHintType.ALSO_INVERTED, true },
            { DecodeHintType.PURE_BARCODE, false }
        }
    };

    private static string? DecodeRgb(MultiFormatReader reader, byte[] rgb, int width, int height)
    {
        var source = new RGBLuminanceSource(rgb, width, height);
        var binaryBitmap = new BinaryBitmap(new HybridBinarizer(source));
        return reader.decode(binaryBitmap)?.Text;
    }
}
