#!/bin/bash

shopt -s nullglob
applications_files=(artifacts/Application/*/*.json)

for filename in "${applications_files[@]}"
do
   translations=$(jq '.objects[] | {name: .fieldName, translations: .attributes[].translation[]?} ' $filename)
   echo "$translations"
done 

