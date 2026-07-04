using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    /// <summary>
    /// Search helper for flat NKT dictionaries (TNVED, measure units, etc.).
    /// </summary>
    public class NationalCatalogDictionaryService
    {
        private readonly NationalCatalogClient _client;
        private readonly string _dictionaryCode;

        /// <summary>
        /// Shop/retail words are not TNVED terms. Map them to a small apparel suggestion list.
        /// </summary>
        private static readonly Dictionary<string, string> RetailTermGroup =
            new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "топ", "apparel_knit" },
                { "топы", "apparel_knit" },
                { "футболка", "apparel_knit" },
                { "футболки", "apparel_knit" },
                { "майка", "apparel_knit" },
                { "майки", "apparel_knit" },
                { "блузка", "apparel_blouse" },
                { "блуза", "apparel_blouse" },
                { "рубашка", "apparel_shirt" },
                { "свитер", "apparel_sweater" },
                { "пуловер", "apparel_sweater" },
                { "толстовка", "apparel_sweater" },
                { "платье", "apparel_dress" },
                { "юбка", "apparel_dress" },
                { "брюки", "apparel_dress" },
                { "трикотаж", "apparel_knit" },
                { "одежда", "apparel_knit" }
            };

        /// <summary>
        /// Common EAEU TNVED codes for retail clothing (shown instantly, no full dictionary scan).
        /// </summary>
        private static readonly Dictionary<string, (string Code, string NameRu)[]> ApparelSuggestions =
            new Dictionary<string, (string, string)[]>(StringComparer.OrdinalIgnoreCase)
            {
                {
                    "apparel_knit",
                    new[]
                    {
                        ("6109100000", "Футболки, майки и прочие нательные фуфайки трикотажные, из хлопчатобумажной пряжи"),
                        ("6109900000", "Футболки, майки и прочие нательные фуфайки трикотажные, из прочих текстильных материалов"),
                        ("6105200000", "Рубашки трикотажные мужские или для мальчиков, из химических нитей"),
                        ("6106100000", "Блузки, рубашки и батники трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6106900000", "Блузки, рубашки и батники трикотажные женские, из прочих текстильных материалов")
                    }
                },
                {
                    "apparel_blouse",
                    new[]
                    {
                        ("6106100000", "Блузки, рубашки и батники трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6106200000", "Блузки, рубашки и батники трикотажные женские, из химических нитей"),
                        ("6106900000", "Блузки, рубашки и батники трикотажные женские, из прочих текстильных материалов"),
                        ("6206400000", "Блузки, рубашки и батники женские, из химических нитей (нетрикотажные)")
                    }
                },
                {
                    "apparel_shirt",
                    new[]
                    {
                        ("6105100000", "Рубашки трикотажные мужские или для мальчиков, из хлопчатобумажной пряжи"),
                        ("6105200000", "Рубашки трикотажные мужские или для мальчиков, из химических нитей"),
                        ("6205200000", "Рубашки мужские или для мальчиков, из хлопчатобумажной пряжи")
                    }
                },
                {
                    "apparel_sweater",
                    new[]
                    {
                        ("6110200000", "Свитеры, пуловеры, джемперы и аналогичные изделия, из хлопчатобумажной пряжи"),
                        ("6110300000", "Свитеры, пуловеры, джемперы и аналогичные изделия, из химических нитей"),
                        ("6110900000", "Свитеры, пуловеры, джемперы и аналогичные изделия, из прочих текстильных материалов")
                    }
                },
                {
                    "apparel_dress",
                    new[]
                    {
                        ("6104420000", "Платья трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6104430000", "Платья трикотажные женские, из химических нитей"),
                        ("6104620000", "Брюки, комбинезоны трикотажные женские, из хлопчатобумажной пряжи")
                    }
                }
            };

        public NationalCatalogDictionaryService(NationalCatalogClient client, string dictionaryCode)
        {
            _client = client;
            _dictionaryCode = dictionaryCode;
        }

        public Task<DictionarySearchResult> SearchAsync(
            string query,
            CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return Task.FromResult(DictionarySearchResult.Empty("Введите запрос и нажмите «Найти»."));
            }

            string q = query.Trim();

            if (string.Equals(_dictionaryCode, "tnved", StringComparison.OrdinalIgnoreCase)
                && RetailTermGroup.TryGetValue(q, out string group)
                && ApparelSuggestions.TryGetValue(group, out (string Code, string NameRu)[] suggestions))
            {
                List<NktDictionaryItem> items = suggestions
                    .Select(s => new NktDictionaryItem
                    {
                        Code = s.Code,
                        NameRu = s.NameRu,
                        Properties = new NktDictionaryItemProperties
                        {
                            Code = s.Code,
                            NameRu = s.NameRu
                        }
                    })
                    .ToList();

                string status = string.Format(
                    "«{0}» — магазинное название, в ТН ВЭД его нет. Выберите ближайший таможенный код для одежды:",
                    q);

                return Task.FromResult(new DictionarySearchResult(items, status));
            }

            bool looksLikeCode = q.All(char.IsDigit) && q.Length >= 2;
            if (!looksLikeCode && q.Length < 4)
            {
                return Task.FromResult(DictionarySearchResult.Empty(
                    "Для одежды введите: топ, футболка, майка. Или код группы, например 6109."));
            }

            return SearchDictionaryAsync(q, looksLikeCode, cancellationToken);
        }

        private async Task<DictionarySearchResult> SearchDictionaryAsync(
            string query,
            bool looksLikeCode,
            CancellationToken cancellationToken)
        {
            List<NktDictionaryItem> matches = new List<NktDictionaryItem>();
            HashSet<string> seenCodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

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

                    if (!MatchesSearch(item, query, looksLikeCode))
                    {
                        continue;
                    }

                    if (seenCodes.Add(item.ResolvedCode))
                    {
                        matches.Add(item);
                    }
                }

                if (matches.Count >= 50)
                {
                    break;
                }

                if (page >= pageResult.TotalPages || pageResult.TotalPages <= 0)
                {
                    break;
                }
            }

            // Numeric group codes like 6109: if API scan found nothing, fall back to apparel list.
            if (matches.Count == 0 && looksLikeCode && query.StartsWith("61", StringComparison.Ordinal))
            {
                List<NktDictionaryItem> apparel = ApparelSuggestions
                    .SelectMany(g => g.Value)
                    .Where(s => s.Code.StartsWith(query, StringComparison.OrdinalIgnoreCase))
                    .GroupBy(s => s.Code)
                    .Select(g => g.First())
                    .Select(s => new NktDictionaryItem
                    {
                        Code = s.Code,
                        NameRu = s.NameRu,
                        Properties = new NktDictionaryItemProperties { Code = s.Code, NameRu = s.NameRu }
                    })
                    .ToList();

                if (apparel.Count > 0)
                {
                    return new DictionarySearchResult(
                        apparel,
                        string.Format("Коды группы {0} (одежда/трикотаж). Выберите ближайший:", query));
                }
            }

            if (matches.Count == 0)
            {
                return DictionarySearchResult.Empty(
                    string.Format(
                        "Ничего не найдено по «{0}». Для одежды попробуйте: топ, футболка, майка или 6109.",
                        query));
            }

            return new DictionarySearchResult(
                matches.OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase).ToList(),
                string.Format("Найдено: {0}", matches.Count));
        }

        private static bool MatchesSearch(NktDictionaryItem item, string query, bool looksLikeCode)
        {
            string code = item.ResolvedCode ?? string.Empty;
            if (looksLikeCode)
            {
                return code.StartsWith(query, StringComparison.OrdinalIgnoreCase);
            }

            return ContainsWholeWord(item.GetDisplayName(), query)
                || ContainsWholeWord(item.NameRu, query)
                || ContainsWholeWord(item.Properties?.NameRu, query);
        }

        private static bool ContainsWholeWord(string text, string query)
        {
            if (string.IsNullOrWhiteSpace(text) || string.IsNullOrWhiteSpace(query))
            {
                return false;
            }

            int index = 0;
            while (index < text.Length)
            {
                int found = text.IndexOf(query, index, StringComparison.OrdinalIgnoreCase);
                if (found < 0)
                {
                    return false;
                }

                bool startOk = found == 0 || !char.IsLetterOrDigit(text[found - 1]);
                int end = found + query.Length;
                bool endOk = end >= text.Length || !char.IsLetterOrDigit(text[end]);
                if (startOk && endOk)
                {
                    return true;
                }

                index = found + 1;
            }

            return false;
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
