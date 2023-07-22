#!/bin/bash

export BUCKET=ngm-storage-hello
# export URL=https://storage.googleapis.com/$BUCKET/index.html
export URL=http://$BUCKET.storage.googleapis.com
export STATUS_CODE=$(curl -I -s $URL | grep HTTP | awk '{print $2}')

echo $URL

if [[ $STATUS_CODE -ne 200 ]]; then
    echo "Error: HTTP status code is $STATUS_CODE"
    exit 1
else
    echo "Success: HTTP status code is 200"
    exit 0
fi
