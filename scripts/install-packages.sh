#!/usr/bin/env bash
set -euo pipefail

# Installing Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

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
