
### set vars
export PROJECT_ID=$(gcloud config get-value project)
export SVC_ACCOUNT_NAME=tf-deploy
export SVC_ACCOUNT_EMAIL=$SVC_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com


### create account
gcloud iam service-accounts create $SVC_ACCOUNT_NAME --display-name $SVC_ACCOUNT_NAME


### set permissions
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/run.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/storage.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/compute.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/dns.admin

### create json key
gcloud iam service-accounts keys create key.json --iam-account $SVC_ACCOUNT_EMAIL


### make one liner key

cat key.json| jq -c > key-one-line.json
cat key-one-line.json | pbcopy
export GOOGLE_CREDENTIALS=`cat key-one-line.json`
