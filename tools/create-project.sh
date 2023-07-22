#!/bin/bash

# gcloud auth login

gcloud projects create dev-ngm-web

gcloud config get-value project

gcloud config set project dev-ngm-web
gcloud config set project thermal-elixir-373618

# gcloud services enable cloudbuild.googleapis.com run.googleapis.com containerregistry.googleapis.com
