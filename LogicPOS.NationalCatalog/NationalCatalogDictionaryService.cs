using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    /// <summary>
    /// Hierarchical NKT dictionary helper (TNVED and other flat/tree dictionaries).
    /// </summary>
    public class NationalCatalogDictionaryService
    {
        private readonly NationalCatalogClient _client;
        private readonly string _dictionaryCode;
        private static readonly Dictionary<string, CacheEntry> RootsCache =
            new Dictionary<string, CacheEntry>(StringComparer.OrdinalIgnoreCase);
        private static readonly TimeSpan CacheDuration = TimeSpan.FromHours(4);

        private class CacheEntry
        {
            public List<NktDictionaryItem> Roots;
            public DateTime CachedAt;
        }

        public NationalCatalogDictionaryService(NationalCatalogClient client, string dictionaryCode)
        {
            _client = client;
            _dictionaryCode = string.IsNullOrWhiteSpace(dictionaryCode) ? "tnved" : dictionaryCode.Trim();
        }

        public async Task<IReadOnlyList<NktDictionaryItem>> GetRootsAsync(CancellationToken cancellationToken = default)
        {
            lock (RootsCache)
            {
                if (RootsCache.TryGetValue(_dictionaryCode, out CacheEntry cached)
                    && cached?.Roots != null
                    && DateTime.UtcNow - cached.CachedAt < CacheDuration)
                {
                    return cached.Roots;
                }
            }

            List<NktDictionaryItem> roots = await _client
                .GetDictionaryRootsAsync(_dictionaryCode, cancellationToken)
                .ConfigureAwait(false);

            List<NktDictionaryItem> result = roots ?? new List<NktDictionaryItem>();
            lock (RootsCache)
            {
                RootsCache[_dictionaryCode] = new CacheEntry
                {
                    Roots = result,
                    CachedAt = DateTime.UtcNow
                };
            }

            return result;
        }

        public Task<IReadOnlyList<NktDictionaryItem>> GetChildrenAsync(long parentId, CancellationToken cancellationToken = default)
        {
            return _client.GetDictionaryChildrenAsync(_dictionaryCode, parentId, cancellationToken);
        }

        public async Task<DictionarySearchResult> SearchAsync(
            string query,
            CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return DictionarySearchResult.Empty("Введите код или название и нажмите «Найти», либо раскройте дерево.");
            }

            string q = query.Trim();
            List<NktDictionaryItem> matches = new List<NktDictionaryItem>();
            HashSet<string> seenCodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            bool looksLikeCode = q.All(char.IsDigit) && q.Length >= 2;

            for (int page = 1; page <= 30; page++)
            {
                cancellationToken.ThrowIfCancellationRequested();
                NktDictionaryItemsPage pageResult = await _client
                    .GetDictionaryItemsAsync(_dictionaryCode, page, 100, cancellationToken)
                    .ConfigureAwait(false);

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

                    if (!MatchesSearch(item, q, looksLikeCode))
                    {
                        continue;
                    }

                    if (seenCodes.Add(item.ResolvedCode))
                    {
                        matches.Add(item);
                    }
                }

                if (matches.Count >= 200)
                {
                    break;
                }

                if (page >= pageResult.TotalPages || pageResult.TotalPages <= 0)
                {
                    break;
                }
            }

            if (matches.Count == 0)
            {
                return DictionarySearchResult.Empty(
                    string.Format("Ничего не найдено по «{0}». Очистите поиск и выберите код в дереве справочника.", q));
            }

            return new DictionarySearchResult(
                matches.OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase).ToList(),
                string.Format("Найдено: {0}. Двойной клик — выбрать. Пустой поиск — снова дерево.", matches.Count));
        }

        private static bool MatchesSearch(NktDictionaryItem item, string query, bool looksLikeCode)
        {
            string code = item.ResolvedCode ?? string.Empty;
            if (looksLikeCode)
            {
                return code.StartsWith(query, StringComparison.OrdinalIgnoreCase)
                    || code.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0;
            }

            return ContainsIgnoreCase(code, query)
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

    public class DictionarySearchResult
    {
        public IReadOnlyList<NktDictionaryItem> Items { get; }
        public string StatusMessage { get; }

        public DictionarySearchResult(IReadOnlyList<NktDictionaryItem> items, string statusMessage)
        {
            Items = items ?? Array.Empty<NktDictionaryItem>();
            StatusMessage = statusMessage ?? string.Empty;
        }

        public static DictionarySearchResult Empty(string statusMessage)
        {
            return new DictionarySearchResult(Array.Empty<NktDictionaryItem>(), statusMessage);
        }
    }
}
