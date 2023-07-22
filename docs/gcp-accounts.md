### List accounts

```bash
gcloud iam service-accounts list
```

### Create Service Account

```bash
export SVC_ACCOUNT=svc-deploy
export PROJECT_ID=$(gcloud config get-value project)
export SVC_ACCOUNT_EMAIL=$SVC_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com

gcloud iam service-accounts create $SVC_ACCOUNT --display-name $SVC_ACCOUNT

gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/run.admin
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SVC_ACCOUNT_EMAIL --role roles/storage.admin
```

### Create Service Account Key

```bash
gcloud iam service-accounts keys create service-account-key.json --iam-account $SVC_ACCOUNT_EMAIL

# base64 -w 0 service-account-key.json
base64 service-account-key.json | pbcopy
rm -f service-account-key.json
```
