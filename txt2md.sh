#!/bin/bash
year=$1

if [ ! -d "txt/$year" ]; then
  echo "You must have text files for a year before generating markdown for it.";
  exit 1;
fi

if [ ! -d "orders/$year" ]; then
  mkdir orders/$year
fi

textOrders=$(ls txt/$year)
for textOrder in $textOrders; do
  base=$(basename $textOrder .txt)
  rm orders/$year/$base.md

  printf "%s\n%s\n%s\n%s\n%s\n" \
    "---" \
    "title: $base" \
    "category: orders" \
    "year: $year" \
    "---" \
    >> orders/$year/$base.md
  cat txt/$year/$textOrder >> orders/$year/$base.md
done
