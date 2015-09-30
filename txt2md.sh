#!/bin/bash
year=$1

if [ ! -d "_txt/$year" ]; then
  echo "You must have text files for a year before generating markdown for it.";
  exit 1;
fi

if [ ! -d "orders/$year" ]; then
  mkdir orders/$year
fi

textOrders=$(ls _txt/$year)
for textOrder in $textOrders; do
  base=$(basename $textOrder .txt)
  printf "" > orders/$year/$base.md

  printf "%s\n%s\n%s\n%s\n%s\n" \
    "---" \
    "originalname: \"$base\"" \
    "category: orders" \
    "year: $year" \
    "layout: order" \
    >> orders/$year/$base.md

  cat _metadata/$year/$base >> orders/$year/$base.md
  echo "---" >> orders/$year/$base.md
  echo "<pre>" >> orders/$year/$base.md

  cat _txt/$year/$textOrder >> orders/$year/$base.md

  printf "%s\n" "</pre>" >> orders/$year/$base.md
done
