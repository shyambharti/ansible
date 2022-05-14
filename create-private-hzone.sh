#!/bin/bash

if [ -z "$1" ]; then
  echo -e '\e[32mPlease pass private hosted zone name too!\e[0m'
  exit 1
fi

COMPONENT=$1

VPC_ID=$(aws ec2 describe-vpcs | jq '.Vpcs[].VpcId' | sed -e 's/"//g')
PVT_HOST_ZONE=$(aws route53 create-hosted-zone \
            --name "${COMPONENT}" \
            --vpc VPCRegion="us-east-1",VPCId=${VPC_ID} \
            --caller-reference "$(date)")

echo "---------------------------------"
echo "Pvt_hosted-zone :" "${PVT_HOST_ZONE}"