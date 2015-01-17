#!/bin/bash
year=$1

command -v wget >/dev/null 2>&1 || { echo "I require wget but it's not installed. Aborting." >&2; exit 1; }
command -v phantomjs >/dev/null 2>&1 || { echo "I require phantomjs but it's not installed. Aborting." >&2; exit 1; }
command -v gs >/dev/null 2>&1 || { echo "I require gs but it's not installed. Aborting." >&2; exit 1; }
command -v tesseract >/dev/null 2>&1 || { echo "I require tesseract but it's not installed. Aborting." >&2; exit 1; }

if [ ! -d "pdfs/$year" ]; then
  mkdir pdfs/$year
fi

if [ ! -d "pngs/$year" ]; then
  mkdir pngs/$year
fi

if [ ! -d "txt/$year" ]; then
  mkdir txt/$year
fi

echo "Retrieving PDFs for year" $year

pdfUrls=$(phantomjs --load-images=false downloadPdfs.js $year)
cd pdfs/$year
for pdfUrl in $pdfUrls; do
  wget $pdfUrl
done
cd ../..

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
