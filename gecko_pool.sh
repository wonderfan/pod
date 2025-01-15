#!/bin/bash

# Function to get trending pools
get_trending_pools() {
    echo "Fetching trending pools..."
    curl -s -X 'GET' \
      'https://api.geckoterminal.com/api/v2/networks/solana/trending_pools' \
      -H 'accept: application/json' > trending_pools.json
    echo "Trending Pools saved to 'trending_pools.json'"
}

# Function to get new pools
get_new_pools() {
    echo "Fetching new pools..."
    curl -s -X 'GET' \
      'https://api.geckoterminal.com/api/v2/networks/solana/new_pools' \
      -H 'accept: application/json' > new_pools.json
    echo "New Pools saved to 'new_pools.json'"
}

# Execute the functions to fetch data
get_trending_pools
get_new_pools

# Optionally, display some basic info about the fetched pools
echo "First 3 Trending Pools:"
jq '.[] | .id, .attributes.name, .attributes.volume_usd.h24' trending_pools.json | head -n 9

echo "First 3 New Pools:"
jq '.[] | .id, .attributes.name, .attributes.pool_created_at' new_pools.json | head -n 9
