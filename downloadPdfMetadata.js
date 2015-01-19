// Executive Order Metadata Discoverer.
// (c) 2015 Georgia Open Data Project.
// Licensed under the Apache License.
//
// This is a PhantomJS script to discover the URLS of the
// source PDFs of the Executive Orders from the State of
// Georgia's website.

var args = require('system').args,
    fs = require('fs'),
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
    var metadataCollection;
    if (year >= 2013) {
      metadataCollection = page.evaluate(function() {
        return $(".view-executive-orders .views-table tr").map(function(i, elem) {
          var dateText = $(elem).find("td:first").text().trim(),
              dateParts = dateText.substr(0, dateText.length-3).split("."),
              date = "20" + dateParts[2] + "-" + dateParts[0] + "-" + dateParts[1],
              href = $(elem).find("a").attr("href"),
              urlParts = href.split("/"),
              baseName = urlParts[urlParts.length-1].replace(".pdf", ""),
              returnObject = {};

          returnObject[baseName] = {
            'title': $(elem).find("a").text().trim(),
            'date': date
          }

          return returnObject;
        });
      });
    } else {
      throw new Execption("2011 and 2012 aren't supported yet.");
    }

    for (key in metadataCollection) {
      if (! /[0-9]+/.test(key))
        continue;

      var metadata = metadataCollection[key];

      for (filename in metadata) {
        var filepath = "metadata/" + year + "/" + filename,
            content = '';

        for (key in metadata[filename]) {
          content += key + ': "' + metadata[filename][key] + '"\n'
        }

        fs.write(filepath, content, 'w');
      }
    }

    // Clean up and shut down safely. setTimeout is required because of weirdness
    // with JS access rules.
    page.close();
    setTimeout(function(){ phantom.exit(); }, 0);
  });
});
