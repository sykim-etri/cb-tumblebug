#!/bin/bash

#function create_securityGroup() {
    FILE=../conf.env
    if [ ! -f "$FILE" ]; then
        echo "$FILE does not exist."
        exit
    fi

	source ../conf.env
	AUTH="Authorization: Basic $(echo -n $ApiUsername:$ApiPassword | base64)"

	echo "####################################################################"
	echo "## 4. SecurityGroup: Create"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}
	if [ "${CSP}" == "aws" ]; then
		echo "[Test for AWS]"
		INDEX=1
	elif [ "${CSP}" == "azure" ]; then
		echo "[Test for Azure]"
		INDEX=2
	elif [ "${CSP}" == "gcp" ]; then
		echo "[Test for GCP]"
		INDEX=3
	elif [ "${CSP}" == "alibaba" ]; then
		echo "[Test for Alibaba]"
		INDEX=4
	else
		echo "[No acceptable argument was provided (aws, azure, gcp, alibaba, ...). Default: Test for AWS]"
		CSP="aws"
		INDEX=1
	fi

	$CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/cbadm securitygroup create --config $CBTUMBLEBUG_ROOT/src/api/grpc/cbadm/grpc_conf.yaml -i json -o json -d \
	'{
		"nsId":  "'${NSID}'",
		"securityGroup": {
			"name": "'${CONN_CONFIG[$INDEX,$REGION]}'-'${POSTFIX}'",
			"connectionName": "'${CONN_CONFIG[$INDEX,$REGION]}'",
			"vNetId": "'${CONN_CONFIG[$INDEX,$REGION]}'-'${POSTFIX}'",
			"description": "test description",
			"firewallRules": [
						{
							"FromPort": "1",
							"ToPort": "65535",
							"IPProtocol": "tcp",
							"Direction": "inbound"
						},
					{
							"FromPort": "-1",
							"ToPort": "-1",
							"IPProtocol": "icmp",
							"Direction": "inbound"
						}
			]
		}
	}'

#}

#create_securityGroup