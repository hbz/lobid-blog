---
layout: post
title: "Indexing the LoC's Bibframe dataset"
date: 2018-12-19
author: Adrian Pohl
tags: lobid-labs
---


At this year's SWIB conference ([SWIB18](http://swib.org/swib18/programme.html)) we offered a workshop "From LOD to LOUD: making data usable". In that we showed how to create well-structured JSON-LD from RDF data, index it in Elasticsearch, build a simple web application for querying it and use the data with tools like OpenRefine and Kibana. For detais, see the slides at [https://hbz.github.io/swib18-workshop/](https://hbz.github.io/swib18-workshop/).

We had to decide which RDF dataset we would use to be treated in the workshop. In the end, we chose the Bibframe works dataset that the Library of Congress (LoC) had published in June. In parallel to the workshop, we converted and indexed the whole Bibframe dataset.


# Querying the index

Index: [http://es.labs.lobid.org/loc_works/_search](http://es.labs.lobid.org/loc_works/_search)

# Kibana

[http://kibana.labs.lobid.org/](http://kibana.labs.lobid.org/)


# Lessons Learned 


# Feedback to LoC

https://github.com/hbz/swib18-workshop/issues/33