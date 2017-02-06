#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/opt/homebrew-jekyll/bin":$PATH

site="../micro-os-plus.github.io.git"

# Be sure the 'vendor/' folder is excluded, 
# otherwise a strage error occurs.
bundle exec jekyll build --destination "${site}"

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Temporarily move the `reference` folder out of the way, it is 
# too large to be validated.
rm -rf "${site}-reference"
mv "${site}/reference" "${site}-reference"

# --log-level debug \

# Validate images and links (internal & external).
 bundle exec htmlproofer \
--url-ignore="/reference/cmsis-plus/,/pt/,https://www.element14.com/community/.*"  \
"${site}"

# Bring back the `reference` folder, it is needed for deployment.
mv "${site}-reference" "${site}/reference"

echo
echo "Done"
