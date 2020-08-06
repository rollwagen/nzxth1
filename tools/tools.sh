#!/bin/bash

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}  

print_info "Cloning github based tools..."
git clone https://github.com/corpnewt/GenSMBIOS
#git clone https://github.com/headkaze/Hackintool
git clone https://github.com/corpnewt/MountEFI
git clone https://github.com/corpnewt/ProperTree
git clone https://github.com/corpnewt/gibMacOS


print_info "Downloading and unzipping MaciASL tool..."
curl -OL https://github.com/acidanthera/MaciASL/releases/download/1.5.7/MaciASL-1.5.7-RELEASE.zip
unzip -d MaciASL MaciASL-*.zip
rm MaciASL-*.zip

print_info "Installing Hackingtool via 'brew'..."
brew cask install hackintool

# rm -rf GenSMBIOS/  MountEFI/ ProperTree/ gibMacOS/ MaciASL*
