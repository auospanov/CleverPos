using System;
using System.Drawing.Printing;
using System.Text;

namespace LogicPOS.Printing.Utility
{
    /// <summary>
    /// Sends a TSPL test label with barcode (XPrinter and similar label printers).
    /// </summary>
    public static class ThermalPrinterTestPrint
    {
        private const string TestItemTitle = "ITEM 123";
        private const string TestBarcode = "1234567890";

        public static bool TryPrint(
            string printerTypeToken,
            string designation,
            string networkName,
            string encoding,
            int maxCharsPerLineNormal,
            int maxCharsPerLineNormalBold,
            int maxCharsPerLineSmall,
            string cutCommand,
            out string errorMessage)
        {
            errorMessage = null;

            if (string.IsNullOrWhiteSpace(printerTypeToken))
            {
                errorMessage = "Printer type is not set.";
                return false;
            }

            if (printerTypeToken != "THERMAL_PRINTER_WINDOWS" && printerTypeToken != "THERMAL_PRINTER_SOCKET")
            {
                errorMessage = "Test print is only supported for Windows or network socket thermal printers.";
                return false;
            }

            bool isSocket = printerTypeToken == "THERMAL_PRINTER_SOCKET";
            string printerTarget = isSocket ? networkName : designation;

            if (string.IsNullOrWhiteSpace(printerTarget))
            {
                errorMessage = isSocket
                    ? "Network address is empty. Use IP:PORT (e.g. 192.168.1.30:9100)."
                    : "Printer name is empty.";
                return false;
            }

            if (!isSocket && !IsInstalledWindowsPrinter(printerTarget))
            {
                errorMessage = string.Format(
                    "Printer \"{0}\" is not installed in Windows. Select the device from the printer list (e.g. Xprinter XP-365B), not the CleverPos record title.",
                    printerTarget);
                return false;
            }

            if (isSocket && !IsValidSocketAddress(printerTarget, out string socketError))
            {
                errorMessage = socketError;
                return false;
            }

            try
            {
                string tspl = BuildTsplTestLabel(TestItemTitle, TestBarcode, printerTarget);
                byte[] payload = Encoding.ASCII.GetBytes(tspl);

                if (isSocket)
                    Socket.Print.SocketPrint(printerTarget, payload);
                else if (!Windows.RawPrinterHelper.SendBytesToPrinter(printerTarget, payload))
                    throw new InvalidOperationException("Unable to access printer : " + printerTarget);

                return true;
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                return false;
            }
        }

        internal static string BuildTsplTestLabel(string itemTitle, string barcode, string printerName)
        {
            string safeTitle = EscapeTsplString(itemTitle);
            string safeBarcode = EscapeTsplString(barcode);
            string safePrinter = EscapeTsplString(printerName);

            return string.Format(
                "SIZE 58 mm,40 mm\r\n" +
                "GAP 2 mm,0 mm\r\n" +
                "CLS\r\n" +
                "TEXT 40,30,\"3\",0,1,1,\"CleverPos\"\r\n" +
                "TEXT 40,55,\"3\",0,1,1,\"{0}\"\r\n" +
                "TEXT 40,80,\"2\",0,1,1,\"{3}\"\r\n" +
                "BARCODE 40,110,\"128\",80,1,0,2,2,\"{1}\"\r\n" +
                "TEXT 40,200,\"2\",0,1,1,\"{2}\"\r\n" +
                "PRINT 1,1\r\n",
                safeTitle,
                safeBarcode,
                DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                safePrinter);
        }

        private static string EscapeTsplString(string value)
        {
            if (string.IsNullOrEmpty(value))
                return string.Empty;

            return value.Replace("\"", "\"\"");
        }

        private static bool IsValidSocketAddress(string networkName, out string errorMessage)
        {
            errorMessage = null;
            string[] parts = networkName.Split(':');
            if (parts.Length != 2 || string.IsNullOrWhiteSpace(parts[0]) || string.IsNullOrWhiteSpace(parts[1]))
            {
                errorMessage = "Invalid network address. Use IP:PORT (e.g. 192.168.1.30:9100).";
                return false;
            }

            if (!int.TryParse(parts[1], out int port) || port <= 0 || port > 65535)
            {
                errorMessage = "Invalid port in network address.";
                return false;
            }

            return true;
        }

        private static bool IsInstalledWindowsPrinter(string printerName)
        {
            foreach (string installed in PrinterSettings.InstalledPrinters)
            {
                if (string.Equals(installed, printerName, StringComparison.OrdinalIgnoreCase))
                    return true;
            }
            return false;
        }
    }
}
