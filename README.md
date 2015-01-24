# Executive Orders of the State of Georgia

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/gaodp/executive-orders?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This repository hosts the Executive Orders of the State of Georgia in text
format for consumption on the internet and for maximum searchability. Also
included are some scripts that are designed to facilitate the process of
retrieving the PDF versions of the executive orders and translating them into
text using GhostScript and the Tesseract OCR Engine.

## How to use

In order to generate the text versions of orders you'll need to be using a Linux compatible machine
with bash installed. This code was developed on Mac OS X, but should work on any Linux distro as well.

Before beginning, you'll need to make sure you have:

* PhantomJS – Used to retrieve PDF urls from ga.gov
* GhostScript – Used to convert PDFs to PNGs
* Tesseract – Used to convert the PNGs to text.
* Jekyll – Used to serve the archive locally.

The first thing you'll probably be interested in doing is downloading and converting the PDFs for
an entire year. To convert for 2015, for example, you would run:

```
$ ./pdfs2txt.sh 2015
```

This would retrieve the list of URLs for 2015 orders from the Governor's website, download them,
and run them all the way through the conversion pipeline to text. To generate the markdown version
that's used for the web, simply run:

```
$ ./txt2md.sh 2015
```

That will add the relevant Jekyll front matter to the text file so it will display properly on the
web and drop the result in the year folder under orders. To see what things look like locally, just
type:

```
$ jekyll serve
```

And Jekyll will spin up and generate all of the pages. (Might take a minute or two.)

## Contributions welcome!

We welcome contributions of all sorts. Of particular interest to us are:

* Contributions that enhance the readability of the text and markdown versions of orders.
* Contributions that improve the visual look-and-feel of the site.
* Contributions of orders that are missing from our collection.

We're also looking to expand the import scripts in the near future to enable them to pull in metadata
about executive orders as well. This will hopefully allow us to provide meaningful titles on our
archive comparable to those on ga.gov.

## License

The contents of this repository are licensed under the Apache 2 License.

This is a work of the [Georgia Open Data Project](http://gaodp.org).
