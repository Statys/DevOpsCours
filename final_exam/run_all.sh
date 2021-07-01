#!/bin/bash
terraform -chdir=./terraform apply
(cd ansible && bash generate_hosts.sh)
(cd ansible && sudo ansible-playbook -i ./hosts ./main.yml)
(cd ansible && bash get_ip.sh)