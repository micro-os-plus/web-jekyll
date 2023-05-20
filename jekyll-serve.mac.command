#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/.local/homebrew/jekyll/bin":$PATH
bundle exec jekyll serve --baseurl "" --destination _site_local --trace --port 4002

echo
echo "Done"
