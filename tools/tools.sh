#!/bin/bash

# option "-c" will cleanup i.e. delete all downloaded content
while getopts 'c' option
do
  case $option in
    c) ACTION=CLEANUP ;;
  esac
done

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}  

if [ "$ACTION" = "CLEANUP" ]; then
        print_info "Cleaning up (i.e. deleting all downloaded content in this folder)."
	print_info "To uninstall hackingtool execute 'brew cask uninstall hackintool'."
	rm -rf GenSMBIOS/  MountEFI/ ProperTree/ gibMacOS/ MaciASL* OCConfigCompare*
        exit
fi


print_info "Cloning github based tools..."

print_info "GenSMBIOS..."
git clone https://github.com/corpnewt/GenSMBIOS

print_info "MountEFI..."
git clone https://github.com/corpnewt/MountEFI

print_info "ProperTree..."
git clone https://github.com/corpnewt/ProperTree

print_info "gibMacOS..."
git clone https://github.com/corpnewt/gibMacOS

print_info "OCConfigCompare..."
git clone https://github.com/corpnewt/OCConfigCompare


print_info "Downloading and unzipping MaciASL tool..."
curl -s -OL https://github.com/acidanthera/MaciASL/releases/download/1.5.7/MaciASL-1.5.7-RELEASE.zip
unzip -q -d MaciASL MaciASL-*.zip
rm MaciASL-*.zip


print_info "Installing Hackingtool via 'brew' (source available at https://github.com/headkaze/Hackintool)..."
hackintool_installed=`brew cask list --json hackintool | jq '.[]|.token'`
if [ $hackintool_installed = "\"hackintool\"" ]; then
	print_info "Hackintool already installed."
else
	brew cask install hackintool
fi

# IORegistryExplorer
# https://mac.filehorse.com/download-ioregistryexplorer/
# https://mac.filehorse.com/download-ioregistryexplorer/

