#!/bin/bash

shopt -s nullglob
translation_path=(translations/*.txt)
source_path="artifacts/Application/test_app_deployment/test_app_deployment.json"

for path in "${translation_path[@]}"
do
  lang=${path: -6:2}
  echo $lang
  
  cp "$source_path" translation.tmp
  
  while IFS= read -r line
  do
    IFS== read -r key value <<< $line
    echo "$key"
  
    jq --arg k "$key" /
       --arg v "$value" /
       --arg l "$lang" /
      '.objects[]? | select(.fieldname == $k ) | .attributes[]?.translation[]? | select(.language == $l ) | .value |= $v' /
      translation.tmp > translation.tmp
  done < "$path"

  mv translation.tmp "$source_path"
done 
