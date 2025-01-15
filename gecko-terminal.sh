#!/bin/bash

TOKEN_ADDRESS="H1NPJkh3KUJGbpjkyQD5qG1nrpFW7tHiqek5SAbMpump"

curl -s -X 'GET' \
  "https://api.geckoterminal.com/api/v2/networks/solana/tokens/$TOKEN_ADDRESS" \
  -H 'accept: application/json' | jq '.'
