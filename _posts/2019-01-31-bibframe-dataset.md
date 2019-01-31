---
layout: post
title: "Indexing the Bibframe works dataset as JSON-LD"
date: 2019-01-31
author: Adrian Pohl
tags: lobid-labs
---

<div class="alert-info">
&#x1f6c8; This post describes an experimental service running on labs.lobid.org. The described service is not be stable and links in the text might stop working in the future.
</div>


At last year's SWIB conference ([SWIB18](http://swib.org/swib18/programme.html)) the [lobid team](http://lobid.org/team/) offered a workshop "From LOD to LOUD: making data usable". In that we showed how to create well-structured JSON-LD from RDF data, index it in Elasticsearch, build a simple web application for querying it and use the data with tools like OpenRefine and Kibana. For details, see the slides at [https://hbz.github.io/swib18-workshop/](https://hbz.github.io/swib18-workshop/).

We had to decide which RDF dataset we would use to be treated in the workshop. In the end, we chose the Bibframe works dataset (but not the instances dataset) that the Library of Congress (LoC) had [published in June](https://listserv.loc.gov/cgi-bin/wa?A2=BIBFRAME;3141fdaf.1806). As preparation for the workshop, we did an experimental not very quick but rather dirty conversion of the N-Triples to JSON-LD and indexed the whole Bibframe dataset into Elasticsearch.

# The JSON-LD context

The [context](https://json-ld.org/spec/latest/json-ld/#the-context) plays an essential role when creating JSON-LD and in increasing its usability. A central function of the context is to map long property URIs to short keys to be used in the JSON. For example with the line `"label": "http://www.w3.org/2000/01/rdf-schema#label"` in the context, I can now use the key `"label"` in a JSON-LD document and when including the context in the document (for example by referencing it like `"@context": "https://example.org/context.jsonld"`) the key-value pair can be translated to an RDF triple. The context is also used to declare that the values of a specific key should be interpreted as URIs (by saying `"@type": "@id"`) or as a date ([example](https://github.com/hbz/swib18-workshop/blob/85b3d87d2d3d18f7f435a617a3e8b7c104b56b3f/data/context.json#L139-L142)) or to enforce that a key always is used with an array (`"@container": "@set"`), see e.g [here](https://github.com/hbz/swib18-workshop/blob/85b3d87d2d3d18f7f435a617a3e8b7c104b56b3f/data/context.json#L263-L267).

Unfortunately, nobody had already created a context we could reuse. And as a lot of properties and classes are used in the Bibframe works dataset the context grew quite big and its creation took a lot of time and iterations. The result can be found [here](https://github.com/hbz/swib18-workshop/blob/master/data/context.json). It is not perfect but may be of help to others who want to do something similar with the Bibframe dataset.

So we used this JSON-LD context to create JSON-LD from the Bibframe N-Triples and indexed the result in Elastisearch. For some more information on how to create JSON-LD from N-Triples see Fabian's [blog post](http://fsteeg.com/notes/from-rdf-to-json-with-json-ld) about the first part of the workshop.

# Querying the index & visualizing with Kibana

The index can be found here: [http://es.labs.lobid.org/loc_works/_search](http://es.labs.lobid.org/loc_works/_search). You get direct access to the index without a UI. You can use the Kibana instance running against that index as UI. Check it out at [http://kibana.labs.lobid.org/](http://kibana.labs.lobid.org/). There you can for example access the [index pattern](http://kibana.labs.lobid.org/app/kibana#/management/kibana/indices/AWcq7SBQx7AjQfXZ73pv) which gives you an overview over all the fields you can query.

For querying the data, you can use the [Elasticsearch Query String Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-query-string-query.html#query-string-syntax) which allows composing easy  but also rather complex queries against the data. For setting up a Kibana visualization see the [Kibana documentation](https://www.elastic.co/guide/en/kibana/5.6/createvis.html) or take a look at the [example visualizations](http://kibana.labs.lobid.org/app/kibana#/visualize).

Here are some examples which you can use to build your own queries and visualizations:

**Querying for "climate change":**

All records containing the phrase "climate change" somewhere, listing the first 100 (using the `size` parameter) of a total 5124: [http://es.labs.lobid.org/loc_works/_search?q=%22climate%20change%22&size=100](http://es.labs.lobid.org/loc_works/_search?q=%22climate%20change%22&size=100)

If you want to know which subject headings are used in those records, look at the Kibana visualization showing the [top 10 subject headings](http://kibana.labs.lobid.org/goto/6f8434fca70236e694c189aab538aaf8):

![bar chart](/images/20190131_bibframe-dataset/top-10-subjects-climate-change.png)


**Query specific fields:**

Records with topic "Cat owners": [http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22cat%20owners%22](http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22cat%20owners%22)

And here a [visualization comparing the number of record about "Cat owners" (green) with those about "Dog owners" (blue)](http://kibana.labs.lobid.org/goto/36fc3fb32b0983053dcd7ea8bd226ff9):

<img src="/images/20190131_bibframe-dataset/dogs-vs-cats.png" alt="pie chart" style="width:200px !important;height:200px !important;">

**Boolean operators:**

You can use boolean operators connecting two fields, e.g. querying for works about "Dog owners" (`subject.label`) in German (`language.id`): [subject.label:"dog owners"+AND+language.id:"http://id.loc.gov/vocabulary/languages/ger"](http://es.labs.lobid.org/loc_works/_search?q=subject.label:%22dog%20owners%22+AND+language.id:%22http://id.loc.gov/vocabulary/languages/ger%22) (Fun fact: There are no titles about cat owners in German.)

You can also use boolean operators on the content of one field by using brackets, e.g. `subject.authoritativeLabel:(cat*+AND+psychology)` ([query](http://es.labs.lobid.org/loc_works/_search?q=subject.authoritativeLabel:%28cat*+AND+psychology%29&size=100))

**Range queries:**

All resources modified in 2017: [adminMetadata.changeDate:[2017-01-01+TO+2017-12-31]](http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.changeDate:[2017-01-01+TO+2017-12-31])

All resources created in 2017: [adminMetadata.creationDate:[2017-01-01+TO+2017-12-31]](http://es.labs.lobid.org/loc_works/_search?q=adminMetadata.creationDate:[2017-01-01+TO+2017-12-31])

You can also use date fields for visualizations, e.g. [record creation date by year](http://kibana.labs.lobid.org/goto/49a8fee1a547f276673384d65e868939) (What happened from 1981 to 1985?):

![timeline](/images/20190131_bibframe-dataset/timeline-creation-date.png)

**\_exists\_ queries:**
- A list of all records containing subject information: [`_exists_:subject`](http://es.labs.lobid.org/loc_works/_search?q=_exists_:subject)
- And here is a [visualization comparing the number of entries with subject information (green) to those without (blue)](http://kibana.labs.lobid.org/goto/88cc6fabfc3c35076bd3450e6170b08d)

<img src="/images/20190131_bibframe-dataset/subject-donut.png" alt="donut" style="width:200px !important;height:200px !important;">

# Using Kibana and adding visualizations

Feel free to play around with the index and Kibana. you can also [create](http://kibana.labs.lobid.org/app/kibana#/visualize/new) other interesting visualizations. Just take a look at the examples as template. Specifically, we would check for keys that still contain "http" to find out which properties are missing in the context document.

# Lessons Learned

We have learned a lot creating the JSON-LD and indexing it. For [example](https://github.com/hbz/swib18-workshop/issues/23#issuecomment-438217655), the Kibana index pattern page is a good place to find problems in the creation of the compacted JSON-LD.  As the index pattern page is itself based on the [GET mapping API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-get-mapping.html), this insight led us to use the mapping API to [create an automatic check](https://github.com/hbz/lobid-gnd/issues/171) against the [lobid-gnd](http://blog.lobid.org/tags/lobid-gnd) data for not compacted keys.

Another thing we have learned is that it is probably better to create a JSON context by hand than creating it from the ontologies used in a dataset. The ontology approach will give you lots of things in the context that aren't actually used in the data. (Anybody for creating a tool to automatically create a JSON-LD context based on an RDF dataset as input?)

# Feedback to LoC

Working with a dataset always reveals some things that are not correct or could be improved. We collected those in a [separate issue](https://github.com/hbz/swib18-workshop/issues/33) to be submitted to the Library of Congress. Here is what we found while working on this:

- A canonical JSON-LD context for the dataset is missing.
- The list of contributors from `bf:contribution` is not an ordered list, thus missing the contributor order from the actual resource.
- Some properties are used in the dataset whose URIs do not resolve: `http://id.loc.gov/ontologies/bflc/consolidates`, `http://id.loc.gov/ontologies/bflc/relatorMatchKey`, `http://id.loc.gov/ontologies/bflc/procInfo`, `http://id.loc.gov/ontologies/bflc/profile`
- There are redundancies between classes in the [MADS](http://www.loc.gov/mads/rdf/v1) and [Bibframe](http://id.loc.gov/ontologies/bibframe/) vocabularies which both are used: [`bf:GenreForm`](http://id.loc.gov/ontologies/bibframe/GenreForm) and [`mads:GenreForm`](http://www.loc.gov/mads/rdf/v1#GenreForm), [`bf:Temporal`](http://id.loc.gov/ontologies/bibframe/Temporal) and [`mads:Temporal`](http://www.loc.gov/mads/rdf/v1#Temporal), [`bf:Topic`](http://id.loc.gov/ontologies/bibframe/Topic) and [`mads:Topic`](http://www.loc.gov/mads/rdf/v1#Topic)
- In the dataset, the wrong URI is used for `mads:isMemberOfMADSScheme` (instead o an upper case "O" lower case is used).
- Instead of the correct `bf:instrumentalType` the following is used: `bf:instrumentType`
