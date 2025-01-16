#!/bin/bash

usage() {
    echo "Usage: $0 --token <token_address> | --pool <pool_address>"
    exit 1
}

TOKEN_ADDRESS=""
POOL_ADDRESS=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --token) TOKEN_ADDRESS="$2"; shift ;;
        --pool) POOL_ADDRESS="$2"; shift ;;
        *) usage ;;
    esac
    shift
done

if [[ -n "$TOKEN_ADDRESS" && -n "$POOL_ADDRESS" ]]; then
    echo "Error: Both token address and pool address cannot be provided at the same time."
    exit 1
fi

if [[ -z "$TOKEN_ADDRESS" && -z "$POOL_ADDRESS" ]]; then
    echo "Error: Either token address or pool address must be provided."
    usage
fi

if [[ -n "$TOKEN_ADDRESS" ]]; then
    TOKEN_DETAILS=$(curl -s -X 'GET' \
      "https://api.geckoterminal.com/api/v2/networks/solana/tokens/$TOKEN_ADDRESS" \
      -H 'accept: application/json')

    # echo "Token Details:"
    # echo "$TOKEN_DETAILS" | jq '.data'

    FIRST_POOL_ADDRESS=$(echo "$TOKEN_DETAILS" | jq -r '.data.relationships.top_pools.data[0].id' | sed 's/^solana_//')

    if [ -z "$FIRST_POOL_ADDRESS" ] || [ "$FIRST_POOL_ADDRESS" == "null" ]; then
        echo "No pools found for this token or error retrieving pool data."
        exit 1
    fi
else
    FIRST_POOL_ADDRESS="$POOL_ADDRESS"
fi

POOL_DATA=$(curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/pools/$FIRST_POOL_ADDRESS" \
  -H 'accept: application/json')

echo "Pool Data:"
echo "$POOL_DATA" | jq '.data.attributes | {name, base_token_price_usd, pool_created_at, price_change_percentage, transactions}'

OHLCV_DATA=$(curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/pools/$FIRST_POOL_ADDRESS/ohlcv/minute?aggregate=1" \
  -H 'accept: application/json')

echo "OHLCV Data for the Pool :"
echo "$OHLCV_DATA" | jq -r '.data.attributes.ohlcv_list[]|@tsv' | while IFS=$'\t' read -r a b c d e f; do
    time=$(date -d "@$a" "+%Y-%m-%d %H:%M:%S")
    echo "$time $b $c $d $e $f"
done
