// Federal Contract Winner Leads - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Small business construction awards, last 14 days
const run = await client.actor('Turboextract/federal-contract-winners').call({
    "daysBack": 14,
    "keywords": [
        "construction"
    ],
    "smallBusinessOnly": true,
    "maxResults": 300
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.company, item.awardAmount, item.agency, item.startDate);
}
