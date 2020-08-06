#!/bin/bash

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}

print_info "Downloading and unzipping latest 'IntelMausi' kext release..."
download_url=`curl -s https://api.github.com/repos/acidanthera/IntelMausi/releases/latest | grep "browser_download_url" | grep "RELEASE" | cut -d : -f 2,3 | tr -d \ \"`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
#curl -s https://api.github.com/repos/acidanthera/IntelMausi/releases/latest | grep "browser_download_url" | grep "RELEASE" | cut -d : -f 2,3 | tr -d \ \" | xargs curl -OL
curl -OL "$download_url"
unzip -d intelmausi-$version IntelMausi*.zip
rm IntelMausi*.zip


print_info "Downloading and unzipping latest 'Lilu' kext release..."
download_url=`curl -s https://api.github.com/repos/acidanthera/Lilu/releases/latest | grep "browser_download_url" | grep "RELEASE" | cut -d : -f 2,3 | tr -d \ \"`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -d lilu-$version Lilu*.zip
rm Lilu*.zip

