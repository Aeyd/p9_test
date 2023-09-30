#!/bin/bash

shopt -s nullglob
translation_path=(translations/*.json)
source_path="artifacts/Application/test_app_deployment/test_app_deployment.json"

for path in "${translation_path[@]}"
do
  lang=${path: -6:2}
  echo $lang
  tmp=$(mktemp)
  tmp=$(<$source_path)
  
  while IFS= read -r line
  do
    IFS=- read -r key value <<< $line
    echo "$key $value"
    jq --arg k="$key" /
       --arg v="$value" /
       --arg l="$lang" /
      '.objects[]? | select(.fieldname == $k ) | .attributes[]?.translation[]? | select(.language == $l ) | .value |= $v' /
      $tmp > "$tmp"
  done < "$path"

  mv "$tmp" "$source_path"
done 
