#!/bin/bash

set -e

END=10

for PAGE in $(seq 1 $END); do
    curl https://api.github.com/users/miragebot/subscriptions?page=$PAGE | jq '[.[] | { repo: .full_name, tags: ["fromMirageBot"] }]' > data/in/mirage_bot_page$PAGE.json;
done

jq -s add data/in/mirage_bot_page*.json > data/in/all.json
