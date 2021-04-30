#!/bin/bash

#function get_sshKey() {


	TestSetFile=${4:-../testSet.env}
    
    FILE=$TestSetFile
    if [ ! -f "$FILE" ]; then
        echo "$FILE does not exist."
        exit
    fi
	source $TestSetFile
    source ../conf.env
	AUTH="Authorization: Basic $(echo -n $ApiUsername:$ApiPassword | base64)"

	echo "####################################################################"
	echo "## 6. image : Add test association"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}

	source ../common-functions.sh
	getCloudIndex $CSP

	curl -H "${AUTH}" -sX PUT http://$TumblebugServer/tumblebug/ns/$NSID/testAddObjectAssociation/image/${CONN_CONFIG[$INDEX,$REGION]}-${POSTFIX} | jq ''
#}

#get_sshKey
