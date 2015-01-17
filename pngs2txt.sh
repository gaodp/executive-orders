#!/bin/bash
year=$1
pngs=$(ls pngs/$year)
for pngname in $pngs; do
  base=$(basename $pngname .png)
  tesseract pngs/$year/$pngname txt/$year/$base
done
