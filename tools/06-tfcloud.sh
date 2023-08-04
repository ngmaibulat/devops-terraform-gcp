#!/bin/bash

export TOKEN="Create an API token in https://app.terraform.io/app/settings/tokens"

mkdir -p ~/.terraform.d/

cat << EOF | jq > ~/.terraform.d/credentials.tfrc.json
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TOKEN"
    }
  }
}
EOF
