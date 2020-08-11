#!/bin/bash

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}  

print_info "Cloning github based tools..."

print_info "GenSMBIOS..."
git clone https://github.com/corpnewt/GenSMBIOS

print_info "MountEFI..."
git clone https://github.com/corpnewt/MountEFI

print_info "ProperTree..."
git clone https://github.com/corpnewt/ProperTree

print_info "gibMacOS..."
git clone https://github.com/corpnewt/gibMacOS


print_info "Downloading and unzipping MaciASL tool..."
curl -OL https://github.com/acidanthera/MaciASL/releases/download/1.5.7/MaciASL-1.5.7-RELEASE.zip
unzip -d MaciASL MaciASL-*.zip
rm MaciASL-*.zip


print_info "Installing Hackingtool via 'brew' (source available at https://github.com/headkaze/Hackintool)..."
brew cask install hackintool

# IORegistryExplorer
# https://mac.filehorse.com/download-ioregistryexplorer/
# https://mac.filehorse.com/download-ioregistryexplorer/

# rm -rf GenSMBIOS/  MountEFI/ ProperTree/ gibMacOS/ MaciASL*
