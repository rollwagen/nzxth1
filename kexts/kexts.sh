#!/bin/bash

# option "-c" will cleanup i.e. delete all downloaded content
while getopts 'c' option
do
  case $option in
    c) ACTION=CLEANUP ;;
  esac
done

print_info () {
	echo "$(tput bold)$1$(tput sgr 0)"
}

curl_url () {
	if [[ -z "${GITHUB_CLIENT_ID}" ]]; then
		print_info "INFO: consider setting GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET for authenticated api requests (see https://developer.github.com/v3/#rate-limiting)"
		echo `curl -s $1  | jq '.assets[] | select(.browser_download_url | contains("RELEASE")) | .browser_download_url' | tr -d \ \" `
	else
		echo `curl -u $GITHUB_CLIENT_ID:$GITHUB_CLIENT_SECRET -s $1  | jq '.assets[] | select(.browser_download_url |contains("RELEASE")) | .browser_download_url' | tr -d \ \"`
	fi

}

if [ "$ACTION" = "CLEANUP" ]; then
	print_info "Cleaning up (deleting all downloaded content)."
	rm -rf intelmausi-* lilu-* virtualsmc-* whatevergreen-* itlwm*
	exit
fi


print_info "Downloading and unzipping latest 'WhateverGreen' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/whatevergreen/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "Download URL: $download_url"
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -q -d whatevergreen-$version Whatever*.zip
rm Whatever*.zip

print_info "Downloading and unzipping latest 'IntelMausi' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/IntelMausi/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -q -d intelmausi-$version IntelMausi*.zip
rm IntelMausi*.zip

print_info "Downloading and unzipping latest 'Lilu' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/Lilu/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -q -d lilu-$version Lilu*.zip
rm Lilu*.zip

print_info "Downloading and unzipping latest 'VirtualSMC' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/VirtualSMC/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -q -d virtualsmc-$version VirtualSMC*.zip
rm VirtualSMC*.zip


### additional optional kexts ###

print_info "Getting 'itlwm' kext repository from github..."
git clone https://github.com/OpenIntelWireless/itlwm.git
# xcodebuild -project itlwm.xcodeproj -target itlwmx -configuration Release  -sdk macosx10.15



