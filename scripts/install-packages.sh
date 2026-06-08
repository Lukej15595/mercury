#!/usr/bin/env bash
set -euo pipefail

echo "Installing packages..."

packages=()

for file in packages/*.txt; do
    mapfile -t current < <(
        grep -vE '^\s*#|^\s*$' "$file"
    )
    packages+=("${current[@]}")
done

sudo apt update
sudo apt install -y "${packages[@]}"

curl -sS https://starship.rs/install.sh | sh