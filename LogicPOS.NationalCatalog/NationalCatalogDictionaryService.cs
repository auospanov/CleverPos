using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    /// <summary>
    /// Flat TNVED dictionary via /items. Avoids rate limit (100 req/min) with cache + throttle + local retail codes.
    /// </summary>
    public class NationalCatalogDictionaryService
    {
        private const int PageSize = 100;
        private const int MaxApiPagesPerSearch = 6;
        private const int ThrottleMs = 700;
        private static readonly TimeSpan CacheTtl = TimeSpan.FromHours(4);

        private readonly NationalCatalogClient _client;
        private readonly string _dictionaryCode;

        private static readonly object CacheLock = new object();
        private static readonly Dictionary<string, ItemsCache> Caches =
            new Dictionary<string, ItemsCache>(StringComparer.OrdinalIgnoreCase);

        private class ItemsCache
        {
            public readonly List<NktDictionaryItem> Items = new List<NktDictionaryItem>();
            public readonly HashSet<string> Codes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            public int NextPageToFetch = 1;
            public int TotalPages = int.MaxValue;
            public bool FullyLoaded;
            public DateTime LoadedAt = DateTime.UtcNow;
            public DateTime LastRequestAt = DateTime.MinValue;
        }

        private static readonly (string Code, string NameRu)[] HsChapters =
        {
            ("01", "Живые животные"),
            ("02", "Мясо и пищевые мясные субпродукты"),
            ("03", "Рыба и ракообразные"),
            ("04", "Молочная продукция; яйца птиц; мед"),
            ("07", "Овощи и некоторые съедобные корнеплоды"),
            ("08", "Съедобные фрукты и орехи"),
            ("09", "Кофе, чай, мате и пряности"),
            ("10", "Злаки"),
            ("11", "Продукция мукомольно-крупяной промышленности"),
            ("15", "Жиры и масла"),
            ("16", "Готовые продукты из мяса, рыбы"),
            ("17", "Сахар и кондитерские изделия из сахара"),
            ("18", "Какао и продукты из него"),
            ("19", "Готовые продукты из зерна злаков"),
            ("20", "Продукты переработки овощей, фруктов"),
            ("21", "Разные пищевые продукты"),
            ("22", "Алкогольные и безалкогольные напитки"),
            ("24", "Табак"),
            ("30", "Фармацевтическая продукция"),
            ("33", "Эфирные масла и косметика"),
            ("34", "Мыло, моющие средства"),
            ("39", "Пластмассы и изделия из них"),
            ("40", "Каучук, резина и изделия из них"),
            ("42", "Изделия из кожи"),
            ("48", "Бумага и картон"),
            ("49", "Печатные книги, газеты"),
            ("50", "Шелк"),
            ("51", "Шерсть"),
            ("52", "Хлопок"),
            ("54", "Химические нити"),
            ("55", "Химические волокна"),
            ("56", "Вата, войлок и нетканые материалы"),
            ("57", "Ковры"),
            ("58", "Специальные ткани"),
            ("59", "Текстильные материалы пропитанные"),
            ("60", "Трикотажные полотна"),
            ("61", "Одежда и принадлежности к одежде, трикотажные"),
            ("62", "Одежда и принадлежности к одежде, кроме трикотажных"),
            ("63", "Прочие готовые текстильные изделия"),
            ("64", "Обувь"),
            ("65", "Головные уборы"),
            ("69", "Керамические изделия"),
            ("70", "Стекло и изделия из него"),
            ("71", "Жемчуг, драгоценные металлы, ювелирные изделия"),
            ("72", "Черные металлы"),
            ("73", "Изделия из черных металлов"),
            ("76", "Алюминий и изделия из него"),
            ("82", "Инструменты"),
            ("83", "Разные изделия из недрагоценных металлов"),
            ("84", "Машины и механические устройства"),
            ("85", "Электрические машины и оборудование"),
            ("87", "Средства наземного транспорта"),
            ("90", "Оптика, фото, медтехника"),
            ("91", "Часы"),
            ("94", "Мебель, светильники"),
            ("95", "Игрушки, игры и спортивный инвентарь"),
            ("96", "Разные готовые изделия")
        };

        /// <summary>
        /// Retail clothing codes by chapter prefix — shown instantly without API.
        /// </summary>
        private static readonly Dictionary<string, (string Code, string NameRu)[]> LocalByPrefix =
            new Dictionary<string, (string, string)[]>(StringComparer.OrdinalIgnoreCase)
            {
                {
                    "61",
                    new[]
                    {
                        ("6103101000", "Костюмы трикотажные мужские или для мальчиков из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6103109000", "Костюмы трикотажные мужские или для мальчиков из прочих текстильных материалов"),
                        ("6104130000", "Костюмы трикотажные женские или для девочек из синтетических нитей"),
                        ("6104192000", "Костюмы трикотажные женские или для девочек из хлопчатобумажной пряжи"),
                        ("6104199001", "Костюмы трикотажные женские или для девочек из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6104199009", "Прочие костюмы трикотажные женские или для девочек из прочих текстильных материалов"),
                        ("6109100000", "Футболки, майки и прочие нательные фуфайки трикотажные, из хлопчатобумажной пряжи"),
                        ("6109900000", "Футболки, майки и прочие нательные фуфайки трикотажные, из прочих текстильных материалов"),
                        ("6105100000", "Рубашки трикотажные мужские или для мальчиков, из хлопчатобумажной пряжи"),
                        ("6105200000", "Рубашки трикотажные мужские или для мальчиков, из химических нитей"),
                        ("6106100000", "Блузки, рубашки и батники трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6106200000", "Блузки, рубашки и батники трикотажные женские, из химических нитей"),
                        ("6106900000", "Блузки, рубашки и батники трикотажные женские, из прочих текстильных материалов"),
                        ("6104420000", "Платья трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6104430000", "Платья трикотажные женские, из химических нитей"),
                        ("6104620000", "Брюки, комбинезоны трикотажные женские, из хлопчатобумажной пряжи"),
                        ("6112110000", "Костюмы спортивные, трикотажные из хлопчатобумажной пряжи"),
                        ("6112120000", "Костюмы спортивные, трикотажные из синтетических нитей"),
                        ("6112190000", "Костюмы спортивные, трикотажные из прочих текстильных материалов"),
                        ("6110200000", "Свитеры, пуловеры, джемперы, из хлопчатобумажной пряжи"),
                        ("6110300000", "Свитеры, пуловеры, джемперы, из химических нитей"),
                        ("6110900000", "Свитеры, пуловеры, джемперы, из прочих текстильных материалов")
                    }
                },
                {
                    "62",
                    new[]
                    {
                        ("6203110000", "Костюмы мужские или для мальчиков из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6203120000", "Костюмы мужские или для мальчиков из синтетических нитей"),
                        ("6203191000", "Костюмы мужские или для мальчиков из хлопчатобумажной пряжи"),
                        ("6203193000", "Костюмы мужские или для мальчиков из искусственных нитей"),
                        ("6203199000", "Прочие костюмы мужские или для мальчиков из прочих текстильных материалов"),
                        ("6204110000", "Костюмы женские или для девочек из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6204120000", "Костюмы женские или для девочек из хлопчатобумажной пряжи"),
                        ("6204130000", "Костюмы женские или для девочек из синтетических нитей"),
                        ("6204191000", "Костюмы женские или для девочек из искусственных нитей"),
                        ("6204199000", "Прочие костюмы женские или для девочек из прочих текстильных материалов"),
                        ("6205200000", "Рубашки мужские или для мальчиков, из хлопчатобумажной пряжи"),
                        ("6206400000", "Блузки, рубашки и батники женские, из химических нитей"),
                        ("6204420000", "Платья женские, из хлопчатобумажной пряжи"),
                        ("6204620000", "Брюки женские, из хлопчатобумажной пряжи"),
                        ("6211320000", "Спортивные костюмы и лыжные костюмы мужские, из хлопчатобумажной пряжи"),
                        ("6211330000", "Спортивные костюмы и лыжные костюмы мужские, из химических нитей"),
                        ("6211420000", "Спортивные костюмы и лыжные костюмы женские, из хлопчатобумажной пряжи")
                    }
                },
                {
                    "64",
                    new[]
                    {
                        ("6403990000", "Обувь с подошвой из резины/пластмассы и верхом из прочих материалов"),
                        ("6404190000", "Обувь с подошвой из резины/пластмассы и верхом из текстильных материалов")
                    }
                }
            };

        /// <summary>
        /// Term → specific codes (e.g. «костюм») so search by shop name works without API.
        /// </summary>
        private static readonly Dictionary<string, (string Code, string NameRu)[]> LocalByTerm =
            new Dictionary<string, (string, string)[]>(StringComparer.OrdinalIgnoreCase)
            {
                {
                    "костюм",
                    new[]
                    {
                        ("6103101000", "Костюмы трикотажные мужские или для мальчиков из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6103109000", "Костюмы трикотажные мужские или для мальчиков из прочих текстильных материалов"),
                        ("6104130000", "Костюмы трикотажные женские или для девочек из синтетических нитей"),
                        ("6104192000", "Костюмы трикотажные женские или для девочек из хлопчатобумажной пряжи"),
                        ("6104199001", "Костюмы трикотажные женские или для девочек из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6104199009", "Прочие костюмы трикотажные женские или для девочек из прочих текстильных материалов"),
                        ("6112110000", "Костюмы спортивные, трикотажные из хлопчатобумажной пряжи"),
                        ("6112120000", "Костюмы спортивные, трикотажные из синтетических нитей"),
                        ("6112190000", "Костюмы спортивные, трикотажные из прочих текстильных материалов"),
                        ("6203110000", "Костюмы мужские или для мальчиков из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6203120000", "Костюмы мужские или для мальчиков из синтетических нитей"),
                        ("6203191000", "Костюмы мужские или для мальчиков из хлопчатобумажной пряжи"),
                        ("6203193000", "Костюмы мужские или для мальчиков из искусственных нитей"),
                        ("6203199000", "Прочие костюмы мужские или для мальчиков из прочих текстильных материалов"),
                        ("6204110000", "Костюмы женские или для девочек из шерстяной пряжи или пряжи из тонкого волоса животных"),
                        ("6204120000", "Костюмы женские или для девочек из хлопчатобумажной пряжи"),
                        ("6204130000", "Костюмы женские или для девочек из синтетических нитей"),
                        ("6204191000", "Костюмы женские или для девочек из искусственных нитей"),
                        ("6204199000", "Прочие костюмы женские или для девочек из прочих текстильных материалов")
                    }
                },
                {
                    "пиджак",
                    new[]
                    {
                        ("6103310000", "Пиджаки и блейзеры трикотажные мужские, из шерстяной пряжи"),
                        ("6103320000", "Пиджаки и блейзеры трикотажные мужские, из хлопчатобумажной пряжи"),
                        ("6103330000", "Пиджаки и блейзеры трикотажные мужские, из синтетических нитей"),
                        ("6203310000", "Пиджаки и блейзеры мужские, из шерстяной пряжи"),
                        ("6203320000", "Пиджаки и блейзеры мужские, из хлопчатобумажной пряжи"),
                        ("6203330000", "Пиджаки и блейзеры мужские, из синтетических нитей")
                    }
                }
            };

        private static readonly Dictionary<string, string> RetailTermToPrefix =
            new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "топ", "61" },
                { "топы", "61" },
                { "футболка", "61" },
                { "футболки", "61" },
                { "майка", "61" },
                { "майки", "61" },
                { "блузка", "61" },
                { "блуза", "61" },
                { "рубашка", "61" },
                { "свитер", "61" },
                { "пуловер", "61" },
                { "толстовка", "61" },
                { "платье", "61" },
                { "юбка", "61" },
                { "брюки", "61" },
                { "трикотаж", "61" },
                { "одежда", "61" },
                { "костюм", "61" },
                { "костюмы", "61" },
                { "пиджак", "61" },
                { "блейзер", "61" },
                { "жакет", "61" },
                { "обувь", "64" }
            };

        public NationalCatalogDictionaryService(NationalCatalogClient client, string dictionaryCode)
        {
            _client = client;
            _dictionaryCode = string.IsNullOrWhiteSpace(dictionaryCode) ? "tnved" : dictionaryCode.Trim();
        }

        public IReadOnlyList<NktDictionaryItem> GetBrowseChapters()
        {
            return HsChapters
                .Select(c => new NktDictionaryItem
                {
                    Code = c.Code,
                    NameRu = c.NameRu,
                    Leaf = false,
                    HasChildren = true,
                    Properties = new NktDictionaryItemProperties { Code = c.Code, NameRu = c.NameRu }
                })
                .ToList();
        }

        /// <summary>
        /// True if product name/code can be resolved from local TNVED lists (no API).
        /// </summary>
        public static bool HasLocalMatch(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return false;
            }

            string q = text.Trim();
            if (GetLocalItemsByTerm(q).Count > 0)
            {
                return true;
            }

            if (q.All(char.IsDigit) && q.Length >= 2 && GetLocalItems(q).Count > 0)
            {
                return true;
            }

            string prefix = ResolveRetailPrefix(q);
            return !string.IsNullOrWhiteSpace(prefix) && GetLocalItems(prefix).Count > 0;
        }

        public async Task<DictionarySearchResult> SearchAsync(
            string query,
            CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return DictionarySearchResult.Empty("Введите код (например 6109) или название и нажмите «Найти».");
            }

            string q = query.Trim();

            // 0) Exact shop term («костюм», «пиджак») → dedicated local list, no API.
            List<NktDictionaryItem> byTerm = GetLocalItemsByTerm(q);
            if (byTerm.Count > 0)
            {
                return new DictionarySearchResult(
                    byTerm,
                    string.Format(
                        "Коды ТН ВЭД для «{0}»: трикотаж (61xx) и нетрикотаж (62xx). Выберите ближайший.",
                        q));
            }

            string retailPrefix = ResolveRetailPrefix(q);
            if (!string.IsNullOrWhiteSpace(retailPrefix))
            {
                q = retailPrefix;
            }

            bool looksLikeCode = q.All(char.IsDigit) && q.Length >= 2;

            // 1) Instant local retail list — no API, no 429.
            List<NktDictionaryItem> local = GetLocalItems(q);
            if (local.Count > 0)
            {
                return new DictionarySearchResult(
                    local,
                    string.Format(
                        "Показаны частые коды для «{0}» (без запроса к API). При необходимости уточните код, например 6109.",
                        query.Trim()));
            }

            // 2) Filter session cache.
            List<NktDictionaryItem> fromCache = FilterCache(q, looksLikeCode);
            if (fromCache.Count > 0)
            {
                return new DictionarySearchResult(
                    fromCache.Take(200).ToList(),
                    string.Format("Из кэша: {0}. Выберите конечный код.", fromCache.Count));
            }

            // 3) Limited API fill (throttled) — never 40 pages at once.
            try
            {
                await FillCacheLimitedAsync(cancellationToken).ConfigureAwait(false);
            }
            catch (NationalCatalogApiException ex) when (ex.StatusCode == 429)
            {
                fromCache = FilterCache(q, looksLikeCode);
                if (fromCache.Count > 0)
                {
                    return new DictionarySearchResult(
                        fromCache.Take(200).ToList(),
                        "Лимит НКТ 100 запросов/мин. Показано из кэша. Подождите ~1 мин и повторите.");
                }

                return DictionarySearchResult.Empty(
                    "Лимит НКТ: 100 запросов в минуту. Подождите минуту. Для одежды откройте раздел 61 — коды есть без API.");
            }

            fromCache = FilterCache(q, looksLikeCode);
            if (fromCache.Count == 0)
            {
                return DictionarySearchResult.Empty(
                    string.Format(
                        "В загруженной части справочника нет «{0}». Для одежды: раздел 61 или код 6109. Подождите и повторите поиск (лимит 100/мин).",
                        query.Trim()));
            }

            return new DictionarySearchResult(
                fromCache.Take(200).ToList(),
                string.Format("Найдено: {0} (кэш + API). Выберите конечный код.", Math.Min(200, fromCache.Count)));
        }

        private static string ResolveRetailPrefix(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return null;
            }

            string trimmed = text.Trim();
            if (RetailTermToPrefix.TryGetValue(trimmed, out string prefix))
            {
                return prefix;
            }

            foreach (KeyValuePair<string, string> pair in RetailTermToPrefix.OrderByDescending(p => p.Key.Length))
            {
                if (trimmed.IndexOf(pair.Key, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return pair.Value;
                }
            }

            return null;
        }

        private static List<NktDictionaryItem> GetLocalItemsByTerm(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return new List<NktDictionaryItem>();
            }

            string trimmed = text.Trim();
            if (LocalByTerm.TryGetValue(trimmed, out (string Code, string NameRu)[] exact))
            {
                return ToItems(exact);
            }

            foreach (KeyValuePair<string, (string Code, string NameRu)[]> pair in LocalByTerm.OrderByDescending(p => p.Key.Length))
            {
                if (trimmed.IndexOf(pair.Key, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return ToItems(pair.Value);
                }
            }

            if (trimmed.EndsWith("ы", StringComparison.OrdinalIgnoreCase) && trimmed.Length > 2)
            {
                string singular = trimmed.Substring(0, trimmed.Length - 1);
                if (LocalByTerm.TryGetValue(singular, out (string Code, string NameRu)[] pluralMatch))
                {
                    return ToItems(pluralMatch);
                }
            }

            return new List<NktDictionaryItem>();
        }

        private static List<NktDictionaryItem> ToItems((string Code, string NameRu)[] rows)
        {
            return rows
                .Select(row => new NktDictionaryItem
                {
                    Code = row.Code,
                    NameRu = row.NameRu,
                    Leaf = true,
                    Properties = new NktDictionaryItemProperties { Code = row.Code, NameRu = row.NameRu }
                })
                .OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase)
                .ToList();
        }

        private static List<NktDictionaryItem> GetLocalItems(string query)
        {
            if (string.IsNullOrWhiteSpace(query) || !query.All(char.IsDigit))
            {
                return new List<NktDictionaryItem>();
            }

            List<NktDictionaryItem> result = new List<NktDictionaryItem>();
            HashSet<string> seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (KeyValuePair<string, (string Code, string NameRu)[]> pair in LocalByPrefix)
            {
                if (!pair.Key.StartsWith(query, StringComparison.OrdinalIgnoreCase)
                    && !query.StartsWith(pair.Key, StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                foreach ((string Code, string NameRu) row in pair.Value)
                {
                    if (!row.Code.StartsWith(query, StringComparison.OrdinalIgnoreCase))
                    {
                        continue;
                    }

                    if (!seen.Add(row.Code))
                    {
                        continue;
                    }

                    result.Add(new NktDictionaryItem
                    {
                        Code = row.Code,
                        NameRu = row.NameRu,
                        Leaf = true,
                        Properties = new NktDictionaryItemProperties { Code = row.Code, NameRu = row.NameRu }
                    });
                }
            }

            return result.OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase).ToList();
        }

        private List<NktDictionaryItem> FilterCache(string query, bool looksLikeCode)
        {
            ItemsCache cache = GetOrCreateCache();
            lock (CacheLock)
            {
                return cache.Items
                    .Where(i => MatchesSearch(i, query, looksLikeCode))
                    .OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase)
                    .ToList();
            }
        }

        private async Task FillCacheLimitedAsync(CancellationToken cancellationToken)
        {
            ItemsCache cache = GetOrCreateCache();
            int pagesFetched = 0;

            while (pagesFetched < MaxApiPagesPerSearch)
            {
                cancellationToken.ThrowIfCancellationRequested();

                int page;
                lock (CacheLock)
                {
                    if (cache.FullyLoaded || cache.NextPageToFetch > cache.TotalPages)
                    {
                        cache.FullyLoaded = true;
                        return;
                    }

                    page = cache.NextPageToFetch;
                }

                await ThrottleAsync(cache, cancellationToken).ConfigureAwait(false);

                NktDictionaryItemsPage pageResult = await _client
                    .GetDictionaryItemsAsync(_dictionaryCode, page, PageSize, cancellationToken)
                    .ConfigureAwait(false);

                lock (CacheLock)
                {
                    cache.LastRequestAt = DateTime.UtcNow;
                    if (pageResult != null && pageResult.TotalPages > 0)
                    {
                        cache.TotalPages = pageResult.TotalPages;
                    }

                    if (pageResult?.Content != null)
                    {
                        foreach (NktDictionaryItem item in pageResult.Content)
                        {
                            if (item == null || string.IsNullOrWhiteSpace(item.ResolvedCode))
                            {
                                continue;
                            }

                            if (cache.Codes.Add(item.ResolvedCode))
                            {
                                cache.Items.Add(item);
                            }
                        }
                    }

                    cache.NextPageToFetch = page + 1;
                    if (pageResult == null
                        || pageResult.Content == null
                        || pageResult.Content.Count == 0
                        || page >= cache.TotalPages)
                    {
                        cache.FullyLoaded = true;
                    }
                }

                pagesFetched++;
            }
        }

        private ItemsCache GetOrCreateCache()
        {
            lock (CacheLock)
            {
                if (!Caches.TryGetValue(_dictionaryCode, out ItemsCache cache)
                    || DateTime.UtcNow - cache.LoadedAt > CacheTtl)
                {
                    cache = new ItemsCache { LoadedAt = DateTime.UtcNow };
                    Caches[_dictionaryCode] = cache;
                }

                return cache;
            }
        }

        private static async Task ThrottleAsync(ItemsCache cache, CancellationToken cancellationToken)
        {
            TimeSpan wait;
            lock (CacheLock)
            {
                wait = TimeSpan.FromMilliseconds(ThrottleMs) - (DateTime.UtcNow - cache.LastRequestAt);
            }

            if (wait > TimeSpan.Zero)
            {
                await Task.Delay(wait, cancellationToken).ConfigureAwait(false);
            }
        }

        private static bool MatchesSearch(NktDictionaryItem item, string query, bool looksLikeCode)
        {
            string code = item.ResolvedCode ?? string.Empty;
            if (looksLikeCode)
            {
                return code.StartsWith(query, StringComparison.OrdinalIgnoreCase);
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
