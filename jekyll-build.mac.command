#! /bin/bash

cd "$(dirname "$0")"

export PATH=/opt/homebrew-jekyll3/bin:$PATH
bundle exec jekyll build --destination ../micro-os-plus.github.io.git

echo
echo "Done"
