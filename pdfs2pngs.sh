#!/bin/bash
year=$1
pdfs=$(ls pdfs/$year)
for pdfname in $pdfs; do
  base=$(basename $pdfname .pdf)
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r300 -dEPSCrop -sOutputFile=pngs/$year/$base.png pdfs/$year/$pdfname
done
