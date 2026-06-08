#!/usr/bin/env bash
set -euo pipefail

./scripts/install-packages.sh
./scripts/install-docker.sh
./scripts/install-dotfiles.sh

echo "Bootstrap is Complete."