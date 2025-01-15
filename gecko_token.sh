#!/bin/bash

# Token address as a variable
TOKEN_ADDRESS="H1NPJkh3KUJGbpjkyQD5qG1nrpFW7tHiqek5SAbMpump"

# Fetch token details
TOKEN_DETAILS=$(curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/tokens/$TOKEN_ADDRESS" \
  -H 'accept: application/json')

# Pretty print token details
echo "Token Details:"
echo "$TOKEN_DETAILS" | jq '.data'

# Extract the first pool address from the token's relationships (top_pools) and remove "solana_" prefix
FIRST_POOL_ADDRESS=$(echo "$TOKEN_DETAILS" | jq -r '.data.relationships.top_pools.data[0].id' | sed 's/^solana_//')

if [ -z "$FIRST_POOL_ADDRESS" ] || [ "$FIRST_POOL_ADDRESS" == "null" ]; then
    echo "No pools found for this token or error retrieving pool data."
    exit 1
fi

# Fetch volume details for the first pool
VOLUME_DATA=$(curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/pools/$FIRST_POOL_ADDRESS" \
  -H 'accept: application/json')

# Pretty print the entire 'data' part of the volume data response
echo "Volume Data for the First Pool:"
echo "$VOLUME_DATA" | jq '.data'

# Optionally, fetch OHLCV data for more detailed volume analysis (hourly data with aggregation)
OHLCV_DATA=$(curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/pools/$FIRST_POOL_ADDRESS/ohlcv/hour?aggregate=1" \
  -H 'accept: application/json')

echo "OHLCV Data for the First Pool (Hourly, Aggregate 1):"
echo "$OHLCV_DATA" | jq '.data'
