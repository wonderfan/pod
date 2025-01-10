#!/bin/bash

TRENDING_URL="https://github.com/trending"

fetch_trending_repositories() {
    local repos
    repos=$(curl -s "$TRENDING_URL" | awk '/<h2[^>]*>/,/<\/h2>/ {if (match($0, /<a[^>]*href="([^"]+)"/, a)) {print a[1]}}')
    
    if [[ -z "$repos" ]]; then
        echo "No trending repositories found."
        exit 1
    fi

    echo "$repos"
}

create_directory() {
    local dir_name
    dir_name=$(date +"%Y-%m-%d")
    
    if [ -d "$dir_name" ]; then
        rm -rf "$dir_name"
    else
        mkdir -p "$dir_name"
    fi

    echo "$dir_name"
}


clone_repositories() {
    local repos="$1"
    local dir_name="$2"
    
    while IFS= read -r repo; do
        local clone_url="https://github.com/$repo.git"
        local repo_dir="$dir_name/${repo##*/}"
        echo "Cloning $repo into $repo_dir..."
        if ! git clone --depth 1 "$clone_url" "$repo_dir"; then
            echo "Failed to clone $repo"
        fi
    done <<< "$repos"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    trending_repos=$(fetch_trending_repositories)
    directory_name=$(create_directory)
    clone_repositories "$trending_repos" "$directory_name"    
fi
