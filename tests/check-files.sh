#!/bin/bash

gsutil ls gs://ngm-storage-hello/ | grep index.html

if [ $? -eq 0 ]; then
  echo "File exists"
else
  echo "File does not exist"
  exit 1
fi
