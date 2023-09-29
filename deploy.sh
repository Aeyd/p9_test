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

JSON_STRING=$( tr -d '\n\t\r ' <<<"$JSON_STRING" )

printf "%s" "$JSON_STRING"
