# Lambda/log4shell-scan-ldap

1. Upload lambda function( for example named by `log4shell-scan-ldap` )

2. Invoke lambda function
```bash
$ aws lambda invoke --function-name log4shell-scan-ldap --payload $(echo '{"FQDN": "https://your-site.com"}' | base64) response.json
```
