#!/bin/bash

#function get_sshKey() {


	TestSetFile=${4:-../testSet.env}
    if [ ! -f "$TestSetFile" ]; then
        echo "$TestSetFile does not exist."
        exit
    fi
	source $TestSetFile
    source ../conf.env
	
	echo "####################################################################"
	echo "## 3. vNet : Delete test association"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}

	source ../common-functions.sh
	getCloudIndex $CSP

	curl -H "${AUTH}" -sX PUT http://$TumblebugServer/tumblebug/ns/$NSID/testDeleteObjectAssociation/vNet/${CONN_CONFIG[$INDEX,$REGION]}-${POSTFIX} | jq ''
#}

#get_sshKey
