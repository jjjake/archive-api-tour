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

See `scripts/download.sh` for more examples.


## Metadata API

The Metadata API is intended for fast, flexible, and reliable reading and writing of Internet Archive items.

### Metadata Read API

The Metadata Read API is the fastest and most flexible way to retrieve metadata for items on archive.org.
We’ve seen upwards of 1,000 reads per second for some collections!

To retrieve all of an items metadata, simply send a GET request to an URL formatted like so: 

    https://archive.org/metadata/$identifier

For example:

    {
      "created": 1442891019,
      "d1": "ia601507.us.archive.org",
      "d2": "ia801507.us.archive.org",
      "dir": "/4/items/ote",
      "files": [
        {
          "name": "logo_header.jpg",
          "source": "original",
          "mtime": "1442890380",
          "size": "130944",
          "md5": "903dc81ddcd8f5e65a6714e899775319",
          "crc32": "342b6402",
          "sha1": "15517ae1809d1f2013d7b712da093493d9515d4e",
          "format": "Collection Header",
          "rotation": "0"
        },
        {
          "name": "ote_meta.sqlite",
          "source": "original",
          "mtime": "1442890392",
          "size": "6144",
          "md5": "27c27279b39127a61848e537e39e947d",
          "crc32": "5423f287",
          "sha1": "55f453768785364f7981ac1aa9edda858c7b9f43",
          "format": "Metadata"
        },
        {
          "name": "ote_meta.xml",
          "source": "original",
          "mtime": "1442891018",
          "size": "1151",
          "format": "Metadata",
          "md5": "f110f388f4681477ea89c191c319f534",
          "crc32": "fd4be22c",
          "sha1": "6f5bc5ef1f95ab2c56e217e54b836fcad4d0ed59"
        },
        {
          "name": "ote_archive.torrent",
          "source": "metadata",
          "btih": "69c267a163491e0074c0774a28c443f301aa0c78",
          "mtime": "1442891018",
          "size": "1564",
          "md5": "f31e839e5e499720cad1c9c626bbf983",
          "crc32": "07f41602",
          "sha1": "c61d5aca6a81bb74067158c94d54becadbe6f923",
          "format": "Archive BitTorrent"
        },
        {
          "name": "ote_files.xml",
          "source": "original",
          "format": "Metadata",
          "md5": "5420927205cbd13168c028cb4457b77c"
        }
      ],
      "files_count": 5,
      "is_collection": true,
      "item_size": 139803,
      "metadata": {
        "identifier": "ote",
        "collection": "audio",
        "description": "Over the Edge (or OTE) is a sound collage radio program hosted and produced in the United States, and started by Don Joyce.\n\nJoyce was also a member of the pioneering sound collage band Negativland, members of which frequently make guest appearances on Over the Edge. A series of Over the Edge episodes have been released under the Negativland name. Critic Ned Raggett describes Over the Edge as \"a merry trip into an alternate world,\" while critic Stephen Cramer described Over the Edge as \"the longest-running block of free-form radio in the history of radio ... essentially live performance art.\" <small><i>Wikipedia</i></small>",
        "hidden": "true",
        "mediatype": "collection",
        "title": "Over the Edge Radio",
        "publicdate": "2015-09-22 02:53:01",
        "uploader": "jscott@archive.org",
        "addeddate": "2015-09-22 02:53:01",
        "creator": "Over the Edge",
        "num_recent_reviews": "5",
        "num_top_dl": "5"
      },
      "server": "ia601507.us.archive.org",
      "uniq": 1082212925,
      "updated": 1442891022,
      "workable_servers": [
        "ia601507.us.archive.org",
        "ia801507.us.archive.org"
      ]
    }


### Metadata Write API
