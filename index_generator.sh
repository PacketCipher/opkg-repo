#!/bin/bash

INDEX_SCRIPT="../scripts/ipkg-make-index.sh"
USIGN_SCRIPT="../scripts/usign"
KEY="../keys/pcipher-repo.key"

remove_useless_depends() {
  # Lua-Runtime not needed since OpenWRT 22
  sed -i '/^Depends: /s/[, ]*luci-lua-runtime[, ]*/ /g' "$1"
}

# Find all folders containing .ipk files
find . -type f -name '*.ipk' -exec dirname {} \; | sort -u | while read -r folder
do
  # Change the working directory to the folder
  cd "$folder" || exit 1

  # Generates package manifest
  $INDEX_SCRIPT . 2>/dev/null > Packages.manifest
  # Remove dependencies that are not needed anymore
  remove_useless_depends "Packages.manifest"
  # Generate Packages & Packages.gz
  grep -vE '^(Maintainer|LicenseFiles|Source|Require)' Packages.manifest > Packages
  gzip -9nc Packages > Packages.gz
  # Sign the Packages
  $USIGN_SCRIPT -S -m Packages -s "$KEY"

  # Return to the original directory
  cd - || exit 1
done
