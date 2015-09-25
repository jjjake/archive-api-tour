# Archive.org API Tour


----------


## Searching

The Archive.org Advanced Search API can be used to retrieve search results from Archive.org in various formats, including JSON.
You can use this [form](https://archive.org/advancedsearch.php?q=licenseurl:(*creativecommons.org*)&fl[]=identifier,title,mediatype,collection&rows=1&output=json "Advanced Search form") to setup a query.
You may pick what kinds of information you would like returned, how the results should be sorted, and how many results to return. 

For example:

    $ curl 'https://archive.org/advancedsearch.php?q=licenseurl:(*creativecommons.org*)&fl[]=identifier,title,mediatype,collection&rows=1&output=json'
    {
      "responseHeader": {
        "status": 0,
        "QTime": 133,
        "params": {
          "wt": "json",
          "rows": "1",
          "qin": "licenseurl:(*creativecommons.org*)",
          "fl": "identifier,title,mediatype,collection",
          "start": "0",
          "q": "licenseurl:(*creativecommons.org* )"
        }
      },
      "response": {
        "numFound": 2058875,
        "start": 0,
        "docs": [
          {
            "mediatype": "texts",
            "title": "parishdodomisc1a",
            "identifier": "parishdodomisc1a",
            "collection": [
              "opensource"
            ]
          }
        ]
      }
    }

See `scripts/search.sh` for more examples.


## Downloading

High performance downloads can be achieved via the Archive.org web infrastructure using permalinks formatted like so:

    https://archive.org/download/$identifier/$filename

For example:

    $ wget https://archive.org/download/gov.uspto.patents.application.10777955/10777955-2004-02-12-00001-WFEE_text.pdf

See scripts/download.sh for more examples.


## Metadata API

The Metadata API is intended for fast, flexible, and reliable reading and writing of Internet Archive items.

### Metadata Read API

The Metadata Read API is the fastest and most flexible way to retrieve metadata for items on archive.org.
We’ve seen upwards of 1,000 reads per second for some collections!

To retrieve all of an items metadata, simply send a GET request to an URL formatted like so: 

    https://archive.org/metadata/$identifier
