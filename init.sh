#!/bin/bash

print_info () {
	echo -n "$(tput bold)$(tput setaf 3)[INFO] $(tput sgr 0)"
	echo "$(tput bold)$1$(tput sgr 0)"
}

print_info "Initializing sub-folder i.e. download needed tools, binaries, etc..."

print_info "Folder 'examples'..."
cd examples
./examples.sh
cd ..

print_info "Folder 'kexts'..."
cd kexts
./kexts.sh
cd ..

print_info "Folder 'opencore/releases'..."
cd opencore/releases
./opencore.sh
cd ..; cd ..

print_info "Folder 'tools'..."
cd tools
./tools.sh
cd ..

print_info "Done."
