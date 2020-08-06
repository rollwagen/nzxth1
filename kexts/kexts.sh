#!/bin/bash

print_info () {
	echo "$(tput bold)$1$(tput sgr 0)"
}

curl_url () {
	if [[ -z "${GITHUB_CLIENT_ID}" ]]; then
		# NOT defined
		echo `curl -s $1 | grep "browser_download_url" | grep "RELEASE" | cut -d : -f 2,3 | tr -d \ \"`
	else
		# defined - for authenticated requests, see https://developer.github.com/v3/#rate-limiting
		echo `curl -u $GITHUB_CLIENT_ID:$GITHUB_CLIENT_SECRET -s $1 | grep "browser_download_url" | grep "RELEASE" | cut -d : -f 2,3 | tr -d \ \"`
	fi

}


print_info "Downloading and unzipping latest 'IntelMausi' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/IntelMausi/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -d intelmausi-$version IntelMausi*.zip
rm IntelMausi*.zip

print_info "Downloading and unzipping latest 'Lilu' kext release..."
download_url=`curl_url https://api.github.com/repos/acidanthera/Lilu/releases/latest`
version=`echo $download_url | awk -F\/ '{print $8}'`
print_info "VERSION: $version"
curl -OL "$download_url"
unzip -d lilu-$version Lilu*.zip
rm Lilu*.zip

