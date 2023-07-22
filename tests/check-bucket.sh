gsutil ls | grep ngm-storage-hello

if [ $? -eq 0 ]; then
  echo "Bucket exists"
else
  echo "Bucket does not exist"
  exit 1
fi
