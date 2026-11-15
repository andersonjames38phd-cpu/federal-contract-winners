#!/usr/bin/env bash
# Federal Contract Winner Leads - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~federal-contract-winners"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. IT services winners in VA, MD and DC over $250k, last 7 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 7,
    "naicsCodes": [
      "541512",
      "541519"
    ],
    "recipientStates": [
      "VA",
      "MD",
      "DC"
    ],
    "minAmount": 250000
  }'

# 2. Small business construction awards, last 14 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 14,
    "keywords": [
      "construction"
    ],
    "smallBusinessOnly": true,
    "maxResults": 300
  }'

# 3. Department of Defense awards for a date range (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "dateFrom": "2026-10-01",
    "dateTo": "2026-10-31",
    "agencies": [
      "Department of Defense"
    ],
    "minAmount": 1000000
  }'
