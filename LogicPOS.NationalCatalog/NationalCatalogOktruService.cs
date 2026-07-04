using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    public class NationalCatalogOktruService
    {
        public const string DefaultDictionaryCode = "OKTRU";

        private readonly NationalCatalogClient _client;
        private static List<NktDictionaryItem> _cachedRoots;
        private static DateTime _cachedRootsAt = DateTime.MinValue;
        private static readonly TimeSpan CacheDuration = TimeSpan.FromHours(4);

        public NationalCatalogOktruService(NationalCatalogClient client)
        {
            _client = client;
        }

        public async Task<IReadOnlyList<NktDictionaryItem>> GetRootsAsync(CancellationToken cancellationToken = default)
        {
            if (_cachedRoots != null && DateTime.UtcNow - _cachedRootsAt < CacheDuration)
            {
                return _cachedRoots;
            }

            List<NktDictionaryItem> roots = await _client.GetDictionaryRootsAsync(DefaultDictionaryCode, cancellationToken).ConfigureAwait(false);
            _cachedRoots = roots ?? new List<NktDictionaryItem>();
            _cachedRootsAt = DateTime.UtcNow;
            return _cachedRoots;
        }

        public Task<IReadOnlyList<NktDictionaryItem>> GetChildrenAsync(long parentId, CancellationToken cancellationToken = default)
        {
            return _client.GetDictionaryChildrenAsync(DefaultDictionaryCode, parentId, cancellationToken);
        }

        public async Task<IReadOnlyList<NktDictionaryItem>> SearchAsync(string query, CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return Array.Empty<NktDictionaryItem>();
            }

            string q = query.Trim();
            List<NktDictionaryItem> matches = new List<NktDictionaryItem>();
            HashSet<string> seenCodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            for (int page = 1; page <= 30; page++)
            {
                cancellationToken.ThrowIfCancellationRequested();
                NktDictionaryItemsPage pageResult = await _client.GetDictionaryItemsAsync(DefaultDictionaryCode, page, 100, cancellationToken).ConfigureAwait(false);
                if (pageResult?.Content == null || pageResult.Content.Count == 0)
                {
                    break;
                }

                foreach (NktDictionaryItem item in pageResult.Content)
                {
                    if (item == null || string.IsNullOrWhiteSpace(item.ResolvedCode))
                    {
                        continue;
                    }

                    if (!MatchesSearch(item, q))
                    {
                        continue;
                    }

                    if (seenCodes.Add(item.ResolvedCode))
                    {
                        matches.Add(item);
                    }
                }

                if (page >= pageResult.TotalPages || pageResult.TotalPages <= 0)
                {
                    break;
                }

                if (matches.Count >= 200)
                {
                    break;
                }
            }

            return matches
                .OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase)
                .ToList();
        }

        private static bool MatchesSearch(NktDictionaryItem item, string query)
        {
            return ContainsIgnoreCase(item.ResolvedCode, query)
                || ContainsIgnoreCase(item.GetDisplayName(), query)
                || ContainsIgnoreCase(item.NameRu, query)
                || ContainsIgnoreCase(item.NameKk, query)
                || ContainsIgnoreCase(item.Properties?.NameRu, query)
                || ContainsIgnoreCase(item.Properties?.NameKk, query);
        }

        private static bool ContainsIgnoreCase(string value, string query)
        {
            return !string.IsNullOrWhiteSpace(value)
                && value.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0;
        }
    }
}
