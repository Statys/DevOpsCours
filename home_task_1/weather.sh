#!/bin/bash
json_curr_condition=$(curl -s wttr.in/$1?format=j1 | jq '.current_condition[0]')
echo $1
humidity=$(echo $json_curr_condition | jq '.humidity|tonumber')
temp=$(echo $json_curr_condition | jq '.temp_C|tonumber')
echo humidity:$humidity% temp:$temp$'\xc2\xb0'C
