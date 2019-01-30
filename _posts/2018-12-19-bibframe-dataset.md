---
layout: post
title: "Indexing the LoC's Bibframe dataset"
date: 2019-01-31
author: Adrian Pohl
tags: lobid-labs
---

At last year's SWIB conference ([SWIB18](http://swib.org/swib18/programme.html)) we offered a workshop "From LOD to LOUD: making data usable". In that we showed how to create well-structured JSON-LD from RDF data, index it in Elasticsearch, build a simple web application for querying it and use the data with tools like OpenRefine and Kibana. For details, see the slides at [https://hbz.github.io/swib18-workshop/](https://hbz.github.io/swib18-workshop/).

We had to decide which RDF dataset we would use to be treated in the workshop. In the end, we chose the Bibframe works dataset that the Library of Congress (LoC) had [published in June](https://listserv.loc.gov/cgi-bin/wa?A2=BIBFRAME;3141fdaf.1806). As preparation for the workshop, we did an experimental not very quick but rather dirty conversion of the N-Triples to JSON-LD and indexed the whole Bibframe dataset into Elasticsearch.

# Querying the index & visualizing with Kibana

The index can be found here: [http://es.labs.lobid.org/loc_works/_search](http://es.labs.lobid.org/loc_works/_search). You will get direct access to the index without an additional user interface. You will quickly see that the data is not completely cleaned up but as noted above this is only an experimental setup. We also set up a Kibana instance running against that index. Check it out at [http://kibana.labs.lobid.org/](http://kibana.labs.lobid.org/).

For querying the data, you can use the [Elasticsearch Query String Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-query-string-query.html#query-string-syntax) which allows composing easy  but also rather complex queries against the data. For setting up a Kibana visualization see the [Kibana documentation](https://www.elastic.co/guide/en/kibana/5.6/createvis.html) or take a look at the example visualizations at [http://kibana.labs.lobid.org/app/kibana#/visualize?_g=](http://kibana.labs.lobid.org/app/kibana#/visualize?_g=()).

Here are some examples which you can use to build your own queries and visualizations:

- Querying for "climate change":
   - All records containing the phrase "climate change" somewhere, listing the first 100 (using the `size` parameter) of a total 5124: [http://es.labs.lobid.org/loc_works/_search?q=%22climate%20change%22&size=100](http://es.labs.lobid.org/loc_works/_search?q=%22climate%20change%22&size=100)
	 - If you want to know which subject headings are used in those records, look at the Kibana visualization showing the [top 20 subject headings](http://kibana.labs.lobid.org/goto/e68e7f5e5c28b84aaab6fca8c3249679)
- Query specific fields:
   - Records with topic "Cat owners": [http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22cat%20owners%22](http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22cat%20owners%22)
	 - And here a [visualization comparing the number of record about "Cat owners" with those about "Dog owners"](http://kibana.labs.lobid.org/goto/36fc3fb32b0983053dcd7ea8bd226ff9)
- Boolean operates:
   - You can use boolean operators connecting two fields, e.g. querying for works about "Dog owners" (`subject.label`) in German (`language.id`): [http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22dog%20owners%22+AND+language.id:%22http://id.loc.gov/vocabulary/languages/ger%22](http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22dog%20owners%22+AND+language.id:%22http://id.loc.gov/vocabulary/languages/ger%22) (Fun fact: There are no title about cat owners in German.)
   - You can also  use boolean operators on the content of one field: [http://es.labs.lobid.org/loc_works/_search?q=subject.authoritativeLabel:(cat*+AND+psychology)&size=100](http://es.labs.lobid.org/loc_works/_search?q=subject.authoritativeLabel:(cat*+AND+psychology)&size=100)
- Range queries:
   - All resources modified in 2017: [http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.changeDate:[2017-01-01+TO+2017-12-31]](http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.changeDate:[2017-01-01+TO+2017-12-31])
   - All resources created in 2017: [http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.creationDate:[2017-01-01+TO+2017-12-31]](http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.creationDate:[2017-01-01+TO+2017-12-31])
	 - You can also use date fields for visualizations, e.g. [record change date by year](http://kibana.labs.lobid.org/goto/b5d59648a416f70771d617951f634841) or [record creation date by year](http://kibana.labs.lobid.org/goto/46f3edad5e8a60c4741e61cd5bc57466)
- \_exists\_ queries:
   - A list of all records containing subject information: `[_exists_:subject](http://es.labs.lobid.org/loc_works/_search?q=_exists_:subject)`
   - And here is a visualization comparing the number of entries with subject headings to those without: [http://kibana.labs.lobid.org/goto/88cc6fabfc3c35076bd3450e6170b08d](http://kibana.labs.lobid.org/goto/88cc6fabfc3c35076bd3450e6170b08d)

# Using Kibana and adding visualizations

Feel free to play around with it and add other interesting visualizations. Here are some tips on how to proceed.


# Lessons Learned

## Creating a JSON-LD context

- Kibana is helpful in finding problems with JSON-LD compaction --> https://github.com/hbz/swib18-workshop/issues/23#issuecomment-438222154

# Feedback to LoC

https://github.com/hbz/swib18-workshop/issues/33