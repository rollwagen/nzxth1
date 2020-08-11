#!/bin/bash

function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}


print_info "Downloading and unzipping latest 'OpenCore' release..."
download_url=""
if [[ -z "${GITHUB_CLIENT_ID}" ]]; then
	download_url=`curl -s https://api.github.com/repos/acidanthera/OpenCorePkg/releases/latest | jq '.assets[] | select(.browser_download_url | contains("RELEASE")) | .browser_download_url' | tr -d \ \" `
else
	download_url=`curl -u $GITHUB_CLIENT_ID:$GITHUB_CLIENT_SECRET -s https://api.github.com/repos/acidanthera/OpenCorePkg/releases/latest | jq '.assets[] | select(.browser_download_url | contains("RELEASE")) | .browser_download_url' | tr -d \ \" `
fi

version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -d OpenCore-$version OpenCore*.zip
rm OpenCore*.zip


