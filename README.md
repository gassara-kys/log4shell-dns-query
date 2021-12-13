# log4shell-dns-query

Using this tool, you can scan for remote command execution vulnerability CVE-2021-44228 on Apache Log4j at FQDN list.
By looking at the DNS query log, you can check if the target URL is vulnerable.
This tool is useful for checking a large number of websites with logs of domains that you own.

## Route53

### Pre-requirement
1. Enabled DNS query log ([AWS Route53 Query Log](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html#query-logs-viewing))

2. Check CWL (@US East (N. Virginia) Region.)
   - you can check log with dig command.

4. Edit fqdn.txt
```bash
$ vi fqdn.txt

http://xxxx
http://yyyy
http://zzzz
...
```

### Scan

1. Exec script
```bash
$ DOMAIN=your-domain.com ./log4shell-scan.sh
```

2. Check log

### vulnerable-app example 

https://github.com/christophetd/log4shell-vulnerable-app

```bash
$ docker run --name vulnerable-app -p 8080:8080 ghcr.io/christophetd/log4shell-vulnerable-app
```

