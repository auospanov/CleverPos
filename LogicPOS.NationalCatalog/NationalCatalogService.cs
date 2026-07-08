using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using LogicPOS.Domain.Entities;
using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    public class NationalCatalogService
    {
        private readonly NationalCatalogClient _client;

        public NationalCatalogService(string baseUrl, string apiKey)
        {
            _client = new NationalCatalogClient(baseUrl, apiKey);
        }

        public string BaseUrl => _client.BaseUrl;
        public string MaskedApiKey => _client.MaskedApiKey;
        public bool HasApiKey => _client.HasApiKey;

        public static bool IsConfigured(string apiKey, bool enabled)
        {
            return enabled && !string.IsNullOrWhiteSpace(apiKey);
        }

        public fin_articlenationalcatalog GetLink(Session session, fin_article article)
        {
            if (session == null || article == null)
            {
                return null;
            }

            return session.FindObject<fin_articlenationalcatalog>(
                CriteriaOperator.Parse("Article = ?", article.Oid));
        }

        public fin_articlenationalcatalog GetOrCreateLink(Session session, fin_article article)
        {
            fin_articlenationalcatalog link = GetLink(session, article);
            if (link != null)
            {
                return link;
            }

            link = new fin_articlenationalcatalog(session)
            {
                Article = article,
                Gtin = NationalCatalogMapper.NormalizeGtin(article.BarCode)
            };
            return link;
        }

        public async Task<NationalCatalogOperationResult> SubmitRegistrationAsync(
            Session session,
            fin_article article,
            fin_articlenationalcatalog link,
            bool autoPublication,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            string validationError = ValidateForSubmit(article, link);
            if (validationError != null)
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, validationError);
            }

            link.Gtin = NationalCatalogMapper.NormalizeGtin(article.BarCode);
            link.LastError = null;
            if (string.IsNullOrWhiteSpace(link.Quantity))
            {
                link.Quantity = "1";
            }

            if (string.IsNullOrWhiteSpace(link.ManufacturerName))
            {
                link.ManufacturerName = "Не указан";
            }

            LogConnection(log);

            if (IsTerminalStatus(link.Status))
            {
                log?.Invoke(string.Format("Товар уже в НКТ: статус {0}", link.Status));
                return NationalCatalogOperationResult.Ok("Уже зарегистрирован", link.Status, link.RequestId);
            }

            if (!link.RequestId.HasValue || link.RequestId.Value <= 0)
            {
                log?.Invoke("Проверка существующих заявок в НКТ по GTIN...");
                NationalCatalogOperationResult existing = await TryLinkExistingByGtinAsync(session, article, link, log, cancellationToken).ConfigureAwait(false);
                if (existing != null && existing.Code == NationalCatalogResultCode.LinkedExisting)
                {
                    log?.Invoke(string.Format("Найден черновик RequestId={0}, статус {1}", link.RequestId, link.Status));
                }
                else if (existing != null && existing.Code != NationalCatalogResultCode.NotFound)
                {
                    return existing;
                }
            }

            if (IsReadyToPublish(link.Status))
            {
                log?.Invoke("Заявка уже прошла модерацию — нажмите «Опубликовать».");
                return NationalCatalogOperationResult.Ok("Готово к публикации", link.Status, link.RequestId);
            }

            if (IsAwaitingModeration(link.Status))
            {
                log?.Invoke(string.Format("Заявка уже на модерации (статус {0}).", link.Status));
                return NationalCatalogOperationResult.Ok("Ожидает модерации", link.Status, link.RequestId);
            }

            List<NktAttributeDefinition> attributeDefinitions = null;
            try
            {
                log?.Invoke("Загрузка обязательных атрибутов категории ОКТРУ...");
                attributeDefinitions = await _client.GetAttributesAsync(link.Oktru, cancellationToken).ConfigureAwait(false);
            }
            catch (NationalCatalogApiException ex)
            {
                log?.Invoke("Не удалось загрузить схему атрибутов: " + ex.Message);
            }

            NktProductRequestPayload payload = NationalCatalogMapper.BuildMvpPayload(article, link, autoPublication, attributeDefinitions);
            string missingRequired = NationalCatalogMapper.ValidateRequiredAttributes(payload, attributeDefinitions);
            if (missingRequired != null)
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, missingRequired);
            }

            log?.Invoke(string.Format(
                "measure_unit={0}, quantity={1}, tnved={2}, manufacturer={3}, oktru={4}, gtin={5}, attrs={6}",
                NationalCatalogMapper.ResolveMeasureUnitCode(article),
                string.IsNullOrWhiteSpace(link.Quantity) ? "1" : link.Quantity,
                link.Tnved,
                link.ManufacturerName,
                link.Oktru,
                link.Gtin,
                payload.Attributes?.Count ?? 0));

            try
            {
                if (!link.RequestId.HasValue || link.RequestId.Value <= 0)
                {
                    log?.Invoke("Создание черновика заявки (POST)...");
                    NktCreateRequestResponse created = await _client.CreateRequestAsync(payload, cancellationToken).ConfigureAwait(false);
                    link.RequestId = created.Id;
                    link.Status = "new";
                    log?.Invoke(string.Format("Черновик создан, RequestId={0}", created.Id));
                }
                else
                {
                    log?.Invoke(string.Format("Обновление заявки {0} (PUT attributes)...", link.RequestId));
                    await _client.UpdateRequestAsync(link.RequestId.Value, payload, cancellationToken).ConfigureAwait(false);
                }

                log?.Invoke("Отправка на модерацию...");
                await _client.SendToModerationAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);

                NktStatusResponse status = await _client.GetStatusAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);
                link.Status = status?.Code ?? "onModeration";
                link.LastSyncedAt = DateTime.Now;
                link.LastError = null;
                link.Save();

                log?.Invoke(string.Format("Статус: {0} ({1})", status?.Code, status?.Value));
                return NationalCatalogOperationResult.Ok("Заявка отправлена на модерацию", link.Status, link.RequestId);
            }
            catch (NationalCatalogApiException ex)
            {
                link.LastError = ex.Message;
                link.Save();
                log?.Invoke("Ошибка API: " + ex.Message);
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ApiError, ex.Message);
            }
        }

        public async Task<NationalCatalogOperationResult> RefreshStatusAsync(
            fin_articlenationalcatalog link,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            if (link?.RequestId == null || link.RequestId.Value <= 0)
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, "Нет RequestId — сначала отправьте заявку или привяжите из НКТ");
            }

            try
            {
                NktStatusResponse status = await _client.GetStatusAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);
                link.Status = status?.Code;
                link.LastSyncedAt = DateTime.Now;
                link.LastError = null;
                link.Save();

                log?.Invoke(string.Format("Статус: {0} ({1})", status?.Code, status?.Value));
                return NationalCatalogOperationResult.Ok("Статус обновлён", link.Status, link.RequestId);
            }
            catch (NationalCatalogApiException ex)
            {
                link.LastError = ex.Message;
                link.Save();
                log?.Invoke("Ошибка API: " + ex.Message);
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ApiError, ex.Message);
            }
        }

        public async Task<NationalCatalogOperationResult> PublishAsync(
            fin_articlenationalcatalog link,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            if (link?.RequestId == null || link.RequestId.Value <= 0)
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, "Нет RequestId");
            }

            LogConnection(log);

            try
            {
                NktStatusResponse current = await _client.GetStatusAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);
                link.Status = current?.Code;
                link.LastSyncedAt = DateTime.Now;

                if (!IsReadyToPublish(link.Status))
                {
                    string message = string.Format(
                        "Публикация возможна только со статусом readyToPublish (Ready to publish). Сейчас: {0} ({1}). Сначала нажмите «Отправить в НКТ» и дождитесь прохождения модерации.",
                        current?.Code ?? "?",
                        current?.Value ?? "?");
                    log?.Invoke(message);
                    link.Save();
                    return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, message);
                }

                log?.Invoke(string.Format("Публикация заявки {0}...", link.RequestId));
                await _client.PublishAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);

                NktStatusResponse status = await _client.GetStatusAsync(link.RequestId.Value, cancellationToken).ConfigureAwait(false);
                link.Status = status?.Code ?? "completed";
                link.LastSyncedAt = DateTime.Now;
                if (string.Equals(link.Status, "completed", StringComparison.OrdinalIgnoreCase))
                {
                    link.PublishedAt = DateTime.Now;
                }
                link.LastError = null;
                link.Save();

                log?.Invoke(string.Format("После публикации: {0} ({1})", status?.Code, status?.Value));
                return NationalCatalogOperationResult.Ok("Публикация выполнена", link.Status, link.RequestId);
            }
            catch (NationalCatalogApiException ex)
            {
                link.LastError = ex.Message;
                link.Save();
                log?.Invoke("Ошибка API: " + ex.Message);
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ApiError, ex.Message);
            }
        }

        public async Task<NationalCatalogOperationResult> LinkByGtinAsync(
            Session session,
            fin_article article,
            fin_articlenationalcatalog link,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            string gtin = NationalCatalogMapper.NormalizeGtin(link?.Gtin ?? article?.BarCode);
            if (string.IsNullOrWhiteSpace(gtin))
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, "Укажите штрихкод (GTIN)");
            }

            link = link ?? GetOrCreateLink(session, article);
            link.Gtin = gtin;

            return await TryLinkExistingByGtinAsync(session, article, link, log, cancellationToken).ConfigureAwait(false)
                ?? NationalCatalogOperationResult.Fail(NationalCatalogResultCode.NotFound, "Заявка с этим GTIN не найдена в вашем кабинете НКТ");
        }

        public async Task<NationalCatalogOperationResult> ReconcileAllAsync(
            Session session,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            int linked = 0;
            int scanned = 0;

            try
            {
                for (int page = 1; page <= 50; page++)
                {
                    cancellationToken.ThrowIfCancellationRequested();
                    NktRequestListResponse list = await _client.ListRequestsAsync(page, 100, null, cancellationToken).ConfigureAwait(false);
                    if (list?.Content == null || list.Content.Count == 0)
                    {
                        break;
                    }

                    foreach (NktRequestShortItem item in list.Content)
                    {
                        scanned++;
                        NktRequestDetailsResponse details = await _client.GetRequestDetailsAsync(item.Id, cancellationToken).ConfigureAwait(false);
                        string gtin = NationalCatalogMapper.ExtractGtinFromDetails(details);
                        if (string.IsNullOrWhiteSpace(gtin))
                        {
                            continue;
                        }

                        fin_article article = session.FindObject<fin_article>(
                            CriteriaOperator.Parse("BarCode = ? OR BarCode = ?", gtin, gtin.TrimStart('0')));
                        if (article == null)
                        {
                            continue;
                        }

                        fin_articlenationalcatalog link = GetOrCreateLink(session, article);
                        link.RequestId = item.Id;
                        link.Gtin = gtin;
                        link.Status = details?.Status?.Code ?? item.Status?.Code;
                        link.Oktru = link.Oktru ?? NationalCatalogMapper.ExtractOktruFromDetails(details);
                        link.LastSyncedAt = DateTime.Now;
                        link.LastError = null;
                        link.Save();
                        linked++;

                        log?.Invoke(string.Format("Привязано: {0} → GTIN {1}, RequestId={2}, статус {3}",
                            article.Designation, gtin, item.Id, link.Status));
                    }

                    if (page >= list.TotalPages)
                    {
                        break;
                    }

                    await Task.Delay(300, cancellationToken).ConfigureAwait(false);
                }

                log?.Invoke(string.Format("Синхронизация завершена: просмотрено {0}, привязано {1}", scanned, linked));
                return NationalCatalogOperationResult.Ok(string.Format("Привязано {0} из {1} заявок", linked, scanned));
            }
            catch (NationalCatalogApiException ex)
            {
                log?.Invoke("Ошибка API: " + ex.Message);
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ApiError, ex.Message);
            }
        }

        private async Task<NationalCatalogOperationResult> TryLinkExistingByGtinAsync(
            Session session,
            fin_article article,
            fin_articlenationalcatalog link,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            string gtin = NationalCatalogMapper.NormalizeGtin(link.Gtin ?? article.BarCode);
            if (string.IsNullOrWhiteSpace(gtin))
            {
                return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.ValidationError, "Нет GTIN");
            }

            for (int page = 1; page <= 20; page++)
            {
                NktRequestListResponse list = await _client.ListRequestsAsync(page, 100, null, cancellationToken).ConfigureAwait(false);
                if (list?.Content == null || list.Content.Count == 0)
                {
                    return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.NotFound, "Не найдено");
                }

                foreach (NktRequestShortItem item in list.Content)
                {
                    NktRequestDetailsResponse details = await _client.GetRequestDetailsAsync(item.Id, cancellationToken).ConfigureAwait(false);
                    string requestGtin = NationalCatalogMapper.ExtractGtinFromDetails(details);
                    if (!string.Equals(requestGtin, gtin, StringComparison.Ordinal))
                    {
                        continue;
                    }

                    link.RequestId = item.Id;
                    link.Gtin = gtin;
                    link.Status = details?.Status?.Code ?? item.Status?.Code;
                    link.Oktru = link.Oktru ?? NationalCatalogMapper.ExtractOktruFromDetails(details);
                    link.LastSyncedAt = DateTime.Now;
                    link.LastError = null;
                    link.Save();

                    log?.Invoke(string.Format("Найдена заявка RequestId={0}, статус {1}", item.Id, link.Status));
                    NationalCatalogOperationResult linked = NationalCatalogOperationResult.Ok("Привязано к существующей заявке", link.Status, item.Id);
                    linked.Code = NationalCatalogResultCode.LinkedExisting;
                    return linked;
                }

                if (page >= list.TotalPages)
                {
                    break;
                }
            }

            return NationalCatalogOperationResult.Fail(NationalCatalogResultCode.NotFound, "Не найдено");
        }

        private static string ValidateForSubmit(fin_article article, fin_articlenationalcatalog link)
        {
            if (article == null)
            {
                return "Товар не задан";
            }

            if (string.IsNullOrWhiteSpace(NationalCatalogMapper.NormalizeGtin(article.BarCode)))
            {
                return "Укажите штрихкод EAN-13 (GTIN) на вкладке «Склад»";
            }

            if (string.IsNullOrWhiteSpace(article.Designation))
            {
                return "Укажите наименование товара";
            }

            if (link == null || string.IsNullOrWhiteSpace(link.Oktru))
            {
                return "Укажите код ОКТРУ на вкладке «НКТ»";
            }

            if (string.IsNullOrWhiteSpace(link.Tnved))
            {
                return "Выберите ТН ВЭД кнопкой «Выбрать ТН ВЭД» (поиск по названию товара, например «топ» или «футболка»).";
            }

            return null;
        }

        private void LogConnection(Action<string> log)
        {
            log?.Invoke(string.Format("НКТ: {0}, X-API-KEY={1}", _client.BaseUrl, _client.MaskedApiKey));
        }

        private static bool IsTerminalStatus(string status)
        {
            if (string.IsNullOrWhiteSpace(status))
            {
                return false;
            }

            return string.Equals(status, "completed", StringComparison.OrdinalIgnoreCase)
                || string.Equals(status, "existingProductSelected", StringComparison.OrdinalIgnoreCase);
        }

        private static bool IsReadyToPublish(string status)
        {
            return string.Equals(status, "readyToPublish", StringComparison.OrdinalIgnoreCase);
        }

        private static bool IsAwaitingModeration(string status)
        {
            return string.Equals(status, "onModeration", StringComparison.OrdinalIgnoreCase)
                || string.Equals(status, "accepted", StringComparison.OrdinalIgnoreCase);
        }
    }
}
