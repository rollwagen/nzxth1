#!/bin/bash

print_info () {
	echo -n "$(tput bold)$(tput setaf 3)[INFO] $(tput sgr 0)"
	echo "$(tput bold)$1$(tput sgr 0)"
}

#
# Validating existence of used tools
#
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2; exit 1;
fi

if ! [ -x "$(command -v brew)" ]; then
  echo 'Error: brew is not installed.' >&2; exit 1;
fi

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed.' >&2; exit 1;
fi


#
# Initializing.
#
print_info "Initializing sub-folders i.e. downloading needed tools, binaries, etc..."

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
