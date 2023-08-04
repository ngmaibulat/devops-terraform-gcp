#!/bin/bash

# gcloud auth login

export PROJECT_NAME='dev-ngm-web'

gcloud projects create $PROJECT_NAME
gcloud config get-value project
gcloud config set project $PROJECT_NAME

# open project web ui
# enable biling manually
export PROJECT=`gcloud config get-value project`
open https://console.cloud.google.com/home/dashboard?project=$PROJECT


# list enabled APIs
gcloud services list

# enable APIs
gcloud services enable storage.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
