#!/bin/bash

shopt -s nullglob
applications_files=(artifacts/Application/*/*.json)

for filename in "${applications_files[@]}"
do
   translations=$(jq '.objects[]? | {fieldname: .fieldName { .attributes[]?.translation[]?.value } }' $filename)
   echo "$translations"
done 

