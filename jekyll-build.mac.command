#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/opt/homebrew-jekyll/bin":$PATH

site=../micro-os-plus.github.io.git
bundle exec jekyll build --destination "${site}"

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

rm -rf "${site}-reference"
mv "${site}/reference" "${site}-reference"

bundle exec htmlproofer \
--log-level debug \
--url-ignore="/reference/cmsis-plus/,/pt/,https://www.element14.com/community/.*"  \
"${site}"

mv "${site}-reference" "${site}/reference"

echo
echo "Done"
