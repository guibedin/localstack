# Create static website

```bash
tflocal init
tflocal plan -var-file=values.tfvars
tflocal apply -var-file=values.tfvars

http://website.s3-website.localhost.localstack.cloud:4566
```
