#!/bin/bash

shopt -s nullglob
translation_files=(translations/*.json)

for filename in "${translation_files[@]}"
do
  while IFS= read -r line
  do
    echo "$line"
  done < "$filename"
done 

