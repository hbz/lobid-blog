---
layout: post
title: "API documentation, part I: What to document?"
date: 2017-02-03
author: Adrian Pohl
---

The relaunch of the lobid-resources and lobid-organisations API is scheduled for the end of March. This is an ideal possibility to improve our documentation. In a series of two post  The basic questions that came up in the process of creating and thinking about documentation are:

1. What should be we write documentation about?
2. How should we provide documentation? 

We will address each question in a blog post.

# The API

Approaching the first question, let's first take a closer look at the lobid API, what it offers and how.

## The data

lobid serves JSON-LD and HTML, depending on the client. You can choose the format by using content negotiation or by setting a `format` parameter. For now, we are relaunching these two endpoints:

1. lobid-organisations: The [/organisations](https://lobid.org/organisations) endpoint serves information about German-speaking organisations (mainly libraries, archives and museums). Data sources are the German ISIL registry and the core data of the German Library Statistics (Deutsche Bibliotheksstatistik, DBS) 
2. lobid-resources: The [/resources](https://lobid.org/resources) endpoint provides data from the hbz union catalog (approximately 20 M records) as Linked Data. 

This means, lobid is serving data that is created and curated in other systems. For _transforming_ the data from different sources we use [Metafacture](https://github.com/culturegraph/metafacture-core). The concrete technology is not relevant for documentation but it is relevant where the data comes from and that it is altered for presentation via the lobid API.

## Read-only JSON-LD API

So, we have two API endpoints to document. These endpoints currently are read-only, i.e. client interaction in terms of HTTP verbs is limted to GET requests. This makes the documentation of the actual API quite manageable as only two endpoints and their parameters for a GET requests have to be documented. 

As underlying technology, lobid uses [Elasticsearch](https://www.elastic.co/products/elasticsearch), a Lucene-based search engine. The JSON-LD resulting from the transformation process is indexed in Elasticsearch and can be queried by anybody using the [Lucene query syntax](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html). Additionally, we are offering additional parameters – implemented with the [Play framework](https://www.playframework.com/) – to simplify specific kinds of searches.

# Documenting what?

Following from the description above, there are different aspects of the API and the data it provides that may be worthy of documentation. These are:

1. With a focus on the _API_ itself and the JSON it serves (without the "LD"):
  - the different endpoints, the types of resources they describe and their API parameters
  - the Lucene query syntax
  - the query results: 
    - the structure of a result
    - the JSON keys used for a specific resource type and their type of content (URIs, uncontrolled text, controlled values etc.) and whether a key can hold multiple values or only holds one
2. With regard to the data being _Linked Data_: Some people will be interested in the RDF vocabularies and properties/classes we use. 
3. People might be interested in the _coverage_ of specific information over the whole data set, e.g.: How many bibliographic resources actually have information about the publication date?
4. With regard to _provenance_ of the data: People – especially librarians – might want to know from which field in the source data a specific information is derived. This would mean providing documentation of the mappings.
