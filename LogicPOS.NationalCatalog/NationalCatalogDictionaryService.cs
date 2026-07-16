using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    /// <summary>
    /// Flat NKT dictionary helper (TNVED has no /roots — only /items).
    /// Browse UX: synthetic HS chapters + prefix search via items endpoint.
    /// </summary>
    public class NationalCatalogDictionaryService
    {
        private readonly NationalCatalogClient _client;
        private readonly string _dictionaryCode;

        /// <summary>
        /// Common HS (ТН ВЭД) chapters for retail browsing without /roots API.
        /// </summary>
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

        public async Task<DictionarySearchResult> SearchAsync(
            string query,
            CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return DictionarySearchResult.Empty("Введите код (например 6109) или название и нажмите «Найти».");
            }

            string q = query.Trim();
            List<NktDictionaryItem> matches = new List<NktDictionaryItem>();
            HashSet<string> seenCodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            bool looksLikeCode = q.All(char.IsDigit) && q.Length >= 2;

            for (int page = 1; page <= 40; page++)
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

                if (matches.Count >= 300)
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
                    string.Format(
                        "Ничего не найдено по «{0}». Попробуйте код группы (61, 6109) или откройте «Разделы».",
                        q));
            }

            return new DictionarySearchResult(
                matches.OrderBy(i => i.ResolvedCode, StringComparer.OrdinalIgnoreCase).ToList(),
                string.Format("Найдено: {0}. Выберите конечный код (обычно 10 цифр).", matches.Count));
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
