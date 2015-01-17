#!/bin/bash
year=$1

command -v gs >/dev/null 2>&1 || { echo "I require gs but it's not installed. Aborting." >&2; exit 1; }
command -v tesseract >/dev/null 2>&1 || { echo "I require tesseract but it's not installed. Aborting." >&2; exit 1; }

if [ ! -d "pngs/$year" ]; then
  mkdir pngs/$year
fi

if [ ! -d "txt/$year" ]; then
  mkdir txt/$year
fi

echo "Converting PDFs to PNG images..."

pdfs=$(ls pdfs/$year)
for pdfname in $pdfs; do
  base=$(basename $pdfname .pdf)
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r300 -dEPSCrop -sOutputFile=pngs/$year/$base.png pdfs/$year/$pdfname
done

echo "Converting PNG images to text files..."

pngs=$(ls pngs/$year)
for pngname in $pngs; do
  base=$(basename $pngname .png)
  tesseract pngs/$year/$pngname txt/$year/$base
done
