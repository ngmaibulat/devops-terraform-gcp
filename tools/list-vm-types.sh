

#gcloud config list

#gcloud compute machine-types list


export REGION="us-east1"
export ZONE="us-east1-b"

gcloud compute machine-types list --filter="zone:($ZONE) and guestCpus:1"

