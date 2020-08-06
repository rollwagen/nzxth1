#!/bin/bash

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}  

print_info "Cloning github based tools..."
while IFS= read -r line
do
  git clone "$line"
done < "urls_git.txt"

print_info "Downloading tools..."
while IFS= read -r line
do
  curl -OL "$line"
done < "urls_download.txt"

print_info "Unzipping MaciASL..."
unzip -d MaciASL MaciASL-*.zip
rm MaciASL-*.zip

print_info "Installing hackingtool via 'brew'..."
brew cask install hackintool

# rm -rf GenSMBIOS/ Hackintool/ MountEFI/ ProperTree/ gibMacOS/ MaciASL*
