#! /bin/bash

cd "$(dirname "$0")"

export PATH=/opt/homebrew/bin:$PATH
jekyll build --destination ../micro-os-plus.github.io.git

echo
echo "Done"
