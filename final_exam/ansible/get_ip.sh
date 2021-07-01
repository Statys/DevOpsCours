#!/bin/bash
terraform -chdir=../terraform output | grep ec2_instance_public_ips | grep -o '".*"' | sed 's/"//g'