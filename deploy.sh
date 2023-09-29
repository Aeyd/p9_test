#!/bin/bash
shopt -s nullglob
applications_files=(artifacts/Application/*/*.json)

declare -a applications_data

for filename in "${applications_files[@]}"
do
   value=$(<$filename)
   applications_data+=("$value")
done 

JSON_STRING=$( jq -n \
               --arg appl "$applications_data" \
               '{applications: $appl}' )

read -r JSON_STRING <<<"${JSON_STRING//[$'\t\r\n']}"
echo "$JSON_STRING"
