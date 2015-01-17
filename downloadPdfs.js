// Executive Order PDF Discoverer.
// (c) 2015 Georgia Open Data Project.
// Licensed under the Apache License.
//
// This is a PhantomJS script to discover the URLS of the
// source PDFs of the Executive Orders from the State of
// Georgia's website.

var args = require('system').args,
    year = args[1],
    url = "https://gov.georgia.gov/executive-orders/" + year,
    orderSelector = ".view-executive-orders a";

if (year < 2011) {
  console.error("Years older than 2011 are not supported.");
  phantom.exit(1);
}

if (year < 2013) {
  url = "https://gov.georgia.gov/" + year + "-executive-orders";
}

var page = require('webpage').create();
page.open(url, function() {
  page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js", function() {
    var urls;
    if (year >= 2013) {
      urls = page.evaluate(function() {
        return $(".view-executive-orders a").map(function(i, elem) {
          var href = $(elem).attr("href");

          if (/\.pdf$/.test(href))
            return $(elem).attr("href");
        });
      });
    } else {
      urls = page.evaluate(function() {
        return $(".file a").map(function(i, elem) {
          var href = $(elem).attr("href");

          if (/\.pdf$/.test(href))
            return $(elem).attr("href");
        });
      });
    }

    // List URLs
    for(i = 0; i < urls.length; i++) {
      console.log(urls[i]);
    }

    // Clean up and shut down safely. setTimeout is required because of weirdness
    // with JS access rules.
    page.close();
    setTimeout(function(){ phantom.exit(); }, 0);
  });
});
