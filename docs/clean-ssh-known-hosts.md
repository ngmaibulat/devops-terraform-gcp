```bash
export IP=`terraform output -raw ip`
ssh-keygen -R $IP
```
