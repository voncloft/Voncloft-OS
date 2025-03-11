#!/bin/bash

# Base URL for Firefox Nightly builds
base_url="https://archive.mozilla.org/pub/firefox/nightly/"

# Fetch the latest year/month directory listing
latest_page=$(mktemp)
wget -q -O "$latest_page" "$base_url$(date +%Y)/$(date +%m)/"

# Extract the latest tarball filename
latest_tarball=$(grep -oP 'firefox-\d+\.\d+\.en-US\.linux-x86_64\.tar\.xz' "$latest_page" | sort -V | tail -n 1)

rm "$latest_page"

if [[ -z "$latest_tarball" ]]; then
    echo "Could not determine the latest Firefox version."
    exit 1
fi

# Construct the final download URL
latest_url="$base_url$(date +%Y)/$(date +%m)/$latest_tarball"

echo "Latest Firefox Nightly URL: $latest_url"
