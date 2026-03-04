# Alert Thresholds
<!--
  INSTRUCTIONS:
  Used by Data Agent token_monitor(). Set your token's CoinGecko ID and thresholds.
  Delete these comment blocks before deploying.
-->

## Token Configuration

- **CoinGecko Token ID**: [your-token-id]
  <!-- Find at https://www.coingecko.com — it's in the URL: /en/coins/YOUR-TOKEN-ID -->
- **Token Symbol**: [YOUR_SYMBOL]
- **Primary trading pair**: [e.g. TOKEN/USDT]

## Alert Thresholds

| Metric | Alert Condition | Severity |
|--------|----------------|----------|
| Price change | > ±10% in 1 hour | 🔴 IMMEDIATE |
| Price change | > ±5% in 1 hour | 🟡 NOTABLE |
| Volume spike | > 3x 7-day average | 🔴 IMMEDIATE |
| Market cap change | > ±20% in 24h | 🟡 NOTABLE |

## Monitoring Frequency

- Price check: every 5 minutes
- Full metrics (volume, market cap): every hour
- 7-day rolling average: recalculated daily at 00:00 UTC

## Changelog

| Date | Change |
|------|--------|
| [YYYY-MM-DD] | Initial setup |
