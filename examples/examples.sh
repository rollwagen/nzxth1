function print_info {
	echo "$(tput bold)$1$(tput sgr 0)"
}

print_info "Cloning github based examples..."
git clone https://github.com/SchmockLord/Hackintosh-Intel-i9-10900k-Gigabyte-Z490-Vision-D
