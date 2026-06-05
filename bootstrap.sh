#!/usr/bin/env bash
set -euo pipefail

./scripts/install-packages.sh
./scripts/install-dotfiles.sh
./scripts/install-docker.sh

echo "Bootstrap is Complete."