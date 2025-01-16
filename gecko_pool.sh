#!/bin/bash

# Get current timestamp for file naming
timestamp=$(date +"%Y%m%d%H%M%S")

# Function to fetch pools with an option to skip fetching
fetch_pools() {
    local pool_type=$1
    local fetch=$2
    if [ "$fetch" = "true" ]; then
        curl -s -X 'GET' \
          "https://api.geckoterminal.com/api/v2/networks/solana/${pool_type}_pools" \
          -H 'accept: application/json' > "${pool_type}_pools_${timestamp}.json"
    fi
}

# Parse command-line flag
while getopts "p:" opt; do
    case $opt in
        p)
            pool_flag="${OPTARG,,}" # Convert to lowercase for case-insensitive comparison
            ;;
        \?)
            echo "Invalid option -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Set default values for flags
pool_flag=${pool_flag:-"true"} # If not set, default to true

# Fetch data based on flags
fetch_pools "trending" "$pool_flag"
fetch_pools "new" "$pool_flag"

# Process both files if they exist
for pool_type in trending new; do
    file="${pool_type}_pools_*.json"
    # Find the most recent file matching the pattern
    most_recent_file=$(ls -t $file | head -n1)
    
    if [ -f "$most_recent_file" ]; then
        # Extract the required fields and format as CSV
        jq -r '.data[] | [.attributes.name, .attributes.address, (.relationships.base_token.data.id | sub("^solana_"; "") | sub("^\"|\"$"; ""))] | @csv' "$most_recent_file" > "${pool_type}_pools_${timestamp}.csv"
        
        # Output file for token attributes
        output_file="${pool_type}_token_attributes_${timestamp}.txt"
        
        # Read each line from CSV, use last element as address for token info
        while IFS= read -r line; do
            # Split CSV row and get the last field (token address), remove any quotes
            IFS=',' read -ra ADDR <<< "$line"
            token_address=$(echo ${ADDR[-1]} | tr -d '"')  # Explicitly remove quotes
            
            # Fetch token info
            token_info=$(curl -s -X 'GET' \
              "https://api.geckoterminal.com/api/v2/networks/solana/tokens/$token_address/info" \
              -H 'accept: application/json')
            
            # Extract token attributes
            token_attributes=$(echo "$token_info" | jq -r '.data.attributes')
            
            # Output to console and write to file
            echo "$token_attributes"
            echo "$token_attributes" >> "$output_file"
            
            # Sleep for 1.5 seconds before next fetch
            sleep 2
        done < "${pool_type}_pools_${timestamp}.csv"
    else
        echo "No ${pool_type}_pools file found."
    fi
done
