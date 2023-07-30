#!/bin/bash

cd ../../data


export BUCKET=$1
export CMD="gsutil -m cp -r * gs://$BUCKET"

echo $CMD

$CMD
