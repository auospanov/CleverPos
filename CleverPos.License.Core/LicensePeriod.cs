using System;

namespace CleverPos.License.Core
{
    public static class LicensePeriod
    {
        public static (int Year, int Month) CurrentUtc()
        {
            DateTime now = DateTime.UtcNow;
            return (now.Year, now.Month);
        }

        /// <summary>
        /// Exclusive upper bound: first instant of the next month after the paid period.
        /// </summary>
        public static DateTime ValidUntilExclusiveUtc(int periodYear, int periodMonth)
        {
            if (periodMonth < 1 || periodMonth > 12)
            {
                throw new ArgumentOutOfRangeException(nameof(periodMonth));
            }

            return new DateTime(periodYear, periodMonth, 1, 0, 0, 0, DateTimeKind.Utc).AddMonths(1);
        }

        public static DateTime ValidUntilExclusiveForCurrentMonthUtc()
        {
            (int year, int month) = CurrentUtc();
            return ValidUntilExclusiveUtc(year, month);
        }

        public static bool IsExpired(DateTime validUntilUtc, DateTime? nowUtc = null)
        {
            DateTime now = nowUtc ?? DateTime.UtcNow;
            return now >= validUntilUtc.ToUniversalTime();
        }
    }
}
