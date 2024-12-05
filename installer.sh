#!/bin/bash

# Function to check if sudo is available
is_sudo_available() {
  if command -v sudo >/dev/null 2>&1; then
    return 0  # sudo is available
  else
    return 1  # sudo is not available
  fi
}

# Function to prompt for password for sudo access
get_sudo_password() {
  echo "Please enter your password to proceed with the installation (sudo required):"
  sudo -v  # This will ask for the user's sudo password
}

# Function to install curl and jq if they are not present
install_dependencies() {
  echo "Installing required dependencies (curl and jq)..."
  
  # Update package list
  if is_sudo_available; then
    sudo apt-get update
  else
    apt-get update
  fi

  # Install curl and jq
  if is_sudo_available; then
    sudo apt-get install -y curl jq
  else
    apt-get install -y curl jq
  fi
}

# GitHub repository and release page URL
REPO="akhshyganesh/aliasmate"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

# Check if required dependencies are installed
if ! command -v curl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  echo "curl or jq is not installed. Do you want to install them? (y/n)"
  read -r install_choice
  install_choice="${install_choice:-y}"  # Default to 'y' if the user presses Enter without typing anything
  
  if [[ "$install_choice" =~ ^[Yy]$ ]]; then
    if is_sudo_available; then
      get_sudo_password  # Ask for sudo password
    fi
    install_dependencies  # Install curl and jq
  else
    echo "Skipping installation of curl and jq. These are required to run the script."
    exit 1
  fi
fi

# Get the latest release version and asset URL
echo "Fetching latest release information..."
LATEST_RELEASE=$(curl -s $API_URL | jq -r .tag_name)

# Handle case where the release version can't be retrieved
if [[ -z "$LATEST_RELEASE" || "$LATEST_RELEASE" == "null" ]]; then
  echo "Failed to fetch the latest release version."
  exit 1
fi

DEB_URL=$(curl -s $API_URL | jq -r .assets[0].browser_download_url)

# Check if a .deb file was found
if [[ "$DEB_URL" == "null" || -z "$DEB_URL" ]]; then
  echo "No .deb file found for the latest release."
  exit 1
fi

# Download the latest .deb file using curl
echo "Downloading latest release: $LATEST_RELEASE from $DEB_URL..."
curl -L "$DEB_URL" -o aliasmate_latest.deb

# Check if curl succeeded in downloading the file
if [[ $? -ne 0 ]]; then
  echo "Failed to download the .deb file. Please check your network connection and try again."
  exit 1
fi

# Install the .deb file
echo "Installing aliasmate_latest.deb..."
if is_sudo_available; then
  sudo dpkg -i aliasmate_latest.deb
else
  dpkg -i aliasmate_latest.deb
fi

# Check if dpkg failed
if [[ $? -ne 0 ]]; then
  echo "Installation failed. Attempting to fix missing dependencies..."
  if is_sudo_available; then
    sudo apt-get install -f -y
  else
    apt-get install -f -y
  fi
  if [[ $? -ne 0 ]]; then
    echo "Failed to fix dependencies. Please check your system configuration."
    exit 1
  fi
fi

# Clean up the .deb file after installation
rm aliasmate_latest.deb

echo "Installation complete!"
