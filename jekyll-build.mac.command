#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/.local/homebrew/jekyll/bin":$PATH

site="../micro-os-plus.github.io.git"

# Be sure the 'vendor/' folder is excluded,
# otherwise a strage error occurs.
bundle exec jekyll build --destination "${site}"

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# Temporarily move the `reference` folder out of the way, it is
# too large to be validated.
rm -rf "${site}-reference"
if [ -d "${site}/reference" ]
then
  mv "${site}/reference" "${site}-reference"
fi

# --log-level debug \

# Validate images and links (internal & external).
 bundle exec htmlproofer \
--url-ignore="/reference/cmsis-plus/,/pt/,https://www.element14.com/community/.*"  \
"${site}"

# Bring back the `reference` folder, it is needed for deployment.
if [ -d "${site}-reference" ]
then
  mv "${site}-reference" "${site}/reference"
fi

echo
echo "Done"
