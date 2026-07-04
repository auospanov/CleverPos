using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Kaspi
{
    public static class KaspiTerminalDiscovery
    {
        public static async Task<IReadOnlyList<string>> DiscoverAsync(
            string hintHost,
            int port,
            bool useHttps,
            bool ignoreSslErrors,
            IProgress<string> progress = null,
            CancellationToken cancellationToken = default)
        {
            if (port <= 0)
            {
                port = 8080;
            }

            List<string> prefixes = GetSubnetPrefixes(hintHost);
            if (prefixes.Count == 0)
            {
                return Array.Empty<string>();
            }

            progress?.Report($"Scan {string.Join(", ", prefixes)}*:{port}");

            HashSet<string> openHosts = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            List<Task> tasks = new List<Task>();

            foreach (string prefix in prefixes)
            {
                for (int host = 1; host <= 254; host++)
                {
                    string ip = $"{prefix}.{host}";
                    tasks.Add(ProbeHostPortAsync(ip, port, openHosts, cancellationToken));
                }
            }

            await Task.WhenAll(tasks).ConfigureAwait(false);

            List<string> candidates = openHosts.OrderBy(x => x, StringComparer.OrdinalIgnoreCase).ToList();
            if (candidates.Count == 0)
            {
                return candidates;
            }

            List<string> confirmed = new List<string>();
            foreach (string host in candidates)
            {
                cancellationToken.ThrowIfCancellationRequested();
                progress?.Report($"Check Kaspi API {host}:{port}");

                KaspiSmartPosClient client = new KaspiSmartPosClient(host, port, useHttps, ignoreSslErrors);
                if (await client.ProbeAsync(cancellationToken).ConfigureAwait(false))
                {
                    confirmed.Add(host);
                }
            }

            return confirmed;
        }

        private static List<string> GetSubnetPrefixes(string hintHost)
        {
            HashSet<string> prefixes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            if (!string.IsNullOrWhiteSpace(hintHost) && IPAddress.TryParse(hintHost.Trim(), out IPAddress hintAddress) && hintAddress.AddressFamily == AddressFamily.InterNetwork)
            {
                byte[] bytes = hintAddress.GetAddressBytes();
                prefixes.Add($"{bytes[0]}.{bytes[1]}.{bytes[2]}");
            }

            foreach (NetworkInterface nic in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (nic.OperationalStatus != OperationalStatus.Up ||
                    nic.NetworkInterfaceType == NetworkInterfaceType.Loopback)
                {
                    continue;
                }

                foreach (UnicastIPAddressInformation address in nic.GetIPProperties().UnicastAddresses)
                {
                    if (address.Address.AddressFamily != AddressFamily.InterNetwork)
                    {
                        continue;
                    }

                    byte[] bytes = address.Address.GetAddressBytes();
                    prefixes.Add($"{bytes[0]}.{bytes[1]}.{bytes[2]}");
                }
            }

            return prefixes.ToList();
        }

        private static async Task ProbeHostPortAsync(string host, int port, HashSet<string> openHosts, CancellationToken cancellationToken)
        {
            try
            {
                using (TcpClient client = new TcpClient())
                {
                    Task connectTask = client.ConnectAsync(host, port);
                    Task completed = await Task.WhenAny(connectTask, Task.Delay(250, cancellationToken)).ConfigureAwait(false);
                    if (completed == connectTask && client.Connected)
                    {
                        lock (openHosts)
                        {
                            openHosts.Add(host);
                        }
                    }
                }
            }
            catch
            {
                // ignore unreachable hosts
            }
        }
    }
}
