#!/usr/bin/env bash
set -euo pipefail

echo "Installing Docker..."

# Remove old packages if present
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y "$pkg" || true
done

# Install prerequisites
sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg

# Create keyring directory
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Enable Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Allow current user to use docker without sudo
sudo usermod -aG docker "$USER"

echo ""
echo "Docker installation complete."
echo "Log out and back in for docker group membership to take effect."
echo ""
echo "Verify with:"
echo "  docker run hello-world"