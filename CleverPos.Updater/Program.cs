using System;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Net;
using System.Threading;

namespace CleverPos.Updater
{
    /// <summary>
    /// Downloads a CleverPos zip, waits for POS to exit, extracts over the install folder, restarts CleverPos.
    /// Usage:
    ///   CleverPos.Updater.exe --pid 1234 --url https://api.../updates/CleverPos-latest.zip --target "C:\Pos" --restart CleverPos.exe
    /// </summary>
    internal static class Program
    {
        private static int Main(string[] args)
        {
            try
            {
                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;

                int waitPid = GetIntArg(args, "--pid", 0);
                string url = GetArg(args, "--url");
                string package = GetArg(args, "--package");
                string target = GetArg(args, "--target") ?? AppDomain.CurrentDomain.BaseDirectory;
                string restart = GetArg(args, "--restart") ?? "CleverPos.exe";
                string sha256 = GetArg(args, "--sha256");

                target = Path.GetFullPath(target.TrimEnd('\\', '/'));
                Directory.CreateDirectory(target);

                if (waitPid > 0)
                {
                    WaitForProcessExit(waitPid, TimeSpan.FromMinutes(2));
                }
                else
                {
                    Thread.Sleep(1500);
                }

                string zipPath = package;
                if (string.IsNullOrWhiteSpace(zipPath))
                {
                    if (string.IsNullOrWhiteSpace(url))
                    {
                        Console.Error.WriteLine("Missing --url or --package");
                        return 2;
                    }

                    zipPath = Path.Combine(Path.GetTempPath(), "CleverPos-update-" + Guid.NewGuid().ToString("N") + ".zip");
                    Console.WriteLine("Downloading " + url);
                    using (WebClient client = new WebClient())
                    {
                        client.DownloadFile(url, zipPath);
                    }
                }

                if (!File.Exists(zipPath))
                {
                    Console.Error.WriteLine("Package not found: " + zipPath);
                    return 3;
                }

                if (!string.IsNullOrWhiteSpace(sha256) && !VerifySha256(zipPath, sha256))
                {
                    Console.Error.WriteLine("SHA256 mismatch");
                    return 4;
                }

                string staging = Path.Combine(Path.GetTempPath(), "CleverPos-staging-" + Guid.NewGuid().ToString("N"));
                Directory.CreateDirectory(staging);
                Console.WriteLine("Extracting...");
                ZipFile.ExtractToDirectory(zipPath, staging);

                string contentRoot = ResolveContentRoot(staging);
                Console.WriteLine("Copying to " + target);
                CopyDirectory(contentRoot, target, overwrite: true);

                TryDelete(zipPath);
                TryDeleteDirectory(staging);

                string exePath = Path.Combine(target, restart);
                if (File.Exists(exePath))
                {
                    Console.WriteLine("Starting " + exePath);
                    Process.Start(new ProcessStartInfo
                    {
                        FileName = exePath,
                        WorkingDirectory = target,
                        UseShellExecute = true
                    });
                }
                else
                {
                    Console.Error.WriteLine("Restart exe not found: " + exePath);
                    return 5;
                }

                return 0;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex);
                try
                {
                    File.WriteAllText(
                        Path.Combine(Path.GetTempPath(), "CleverPos.Updater.error.txt"),
                        DateTime.Now.ToString("o") + Environment.NewLine + ex);
                }
                catch
                {
                }

                return 1;
            }
        }

        private static string ResolveContentRoot(string staging)
        {
            // Zip may contain a single top-level folder with CleverPos.exe inside.
            string[] exes = Directory.GetFiles(staging, "CleverPos.exe", SearchOption.AllDirectories);
            if (exes.Length == 1)
            {
                return Path.GetDirectoryName(exes[0]) ?? staging;
            }

            string[] dirs = Directory.GetDirectories(staging);
            if (dirs.Length == 1 && Directory.GetFiles(staging).Length == 0)
            {
                return dirs[0];
            }

            return staging;
        }

        private static void CopyDirectory(string sourceDir, string targetDir, bool overwrite)
        {
            foreach (string dir in Directory.GetDirectories(sourceDir, "*", SearchOption.AllDirectories))
            {
                string rel = dir.Substring(sourceDir.Length).TrimStart('\\', '/');
                Directory.CreateDirectory(Path.Combine(targetDir, rel));
            }

            foreach (string file in Directory.GetFiles(sourceDir, "*", SearchOption.AllDirectories))
            {
                string rel = file.Substring(sourceDir.Length).TrimStart('\\', '/');
                string dest = Path.Combine(targetDir, rel);

                // Don't overwrite the running updater binary mid-copy if it lives in target.
                string fileName = Path.GetFileName(file);
                if (string.Equals(fileName, "CleverPos.Updater.exe", StringComparison.OrdinalIgnoreCase)
                    && IsSamePath(dest, Process.GetCurrentProcess().MainModule?.FileName))
                {
                    continue;
                }

                Directory.CreateDirectory(Path.GetDirectoryName(dest) ?? targetDir);
                File.Copy(file, dest, overwrite);
            }
        }

        private static bool IsSamePath(string a, string b)
        {
            if (string.IsNullOrEmpty(a) || string.IsNullOrEmpty(b))
            {
                return false;
            }

            return string.Equals(Path.GetFullPath(a), Path.GetFullPath(b), StringComparison.OrdinalIgnoreCase);
        }

        private static void WaitForProcessExit(int pid, TimeSpan timeout)
        {
            try
            {
                using (Process process = Process.GetProcessById(pid))
                {
                    if (!process.WaitForExit((int)timeout.TotalMilliseconds))
                    {
                        Console.WriteLine("Process still running after timeout, continuing...");
                    }
                }
            }
            catch (ArgumentException)
            {
                // Already exited
            }
        }

        private static bool VerifySha256(string filePath, string expectedHex)
        {
            using (var sha = System.Security.Cryptography.SHA256.Create())
            using (FileStream stream = File.OpenRead(filePath))
            {
                byte[] hash = sha.ComputeHash(stream);
                string actual = BitConverter.ToString(hash).Replace("-", string.Empty);
                return string.Equals(actual, expectedHex.Trim(), StringComparison.OrdinalIgnoreCase);
            }
        }

        private static string GetArg(string[] args, string name)
        {
            for (int i = 0; i < args.Length - 1; i++)
            {
                if (string.Equals(args[i], name, StringComparison.OrdinalIgnoreCase))
                {
                    return args[i + 1];
                }
            }

            return null;
        }

        private static int GetIntArg(string[] args, string name, int defaultValue)
        {
            string value = GetArg(args, name);
            int parsed;
            return int.TryParse(value, out parsed) ? parsed : defaultValue;
        }

        private static void TryDelete(string path)
        {
            try
            {
                if (File.Exists(path))
                {
                    File.Delete(path);
                }
            }
            catch
            {
            }
        }

        private static void TryDeleteDirectory(string path)
        {
            try
            {
                if (Directory.Exists(path))
                {
                    Directory.Delete(path, true);
                }
            }
            catch
            {
            }
        }
    }
}
