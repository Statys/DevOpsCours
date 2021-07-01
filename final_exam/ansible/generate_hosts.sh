#!/bin/sh
cd $(dirname $0)
HOST=$(terraform -chdir=../terraform output | grep ec2_instance_public_ips | grep -o '".*"' | sed 's/"//g')
#define the template.
eval "echo \"$(cat hosts_template)\" > hosts"