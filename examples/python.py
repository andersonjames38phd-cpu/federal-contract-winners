"""Federal Contract Winner Leads - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# IT services winners in VA, MD and DC over $250k, last 7 days
run = client.actor("Turboextract/federal-contract-winners").call(run_input={
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
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("company"), item.get("awardAmount"), item.get("agency"), item.get("startDate"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
