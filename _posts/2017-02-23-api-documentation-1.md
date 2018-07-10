---
layout: post
title: "Documenting the lobid API, part I: What to document?"
date: 2017-02-23
author: Adrian Pohl
tags: technology
---

The relaunch of lobid-resources and lobid-organisations is scheduled for the end of March. This is an ideal opportunity to improve our documentation. In a series of two blog posts we will examine the basic questions that came up in the process of creating and thinking about documentation for a search API:

1. What should we write documentation about?
2. How should we provide documentation? 

# The API

Approaching the first question, let's start with a closer look at the lobid API, what it offers and how.

## The data

lobid serves JSON-LD and HTML, depending on the client. You can choose the format by using content negotiation or by setting a `format` parameter. For now, we are relaunching these two services:

1. lobid-organisations: The [/organisations](https://lobid.org/organisations) service serves information about German-speaking organisations (mainly libraries, archives and museums). Data sources are the German ISIL registry and the core data of the German Library Statistics (Deutsche Bibliotheksstatistik, DBS). 
2. lobid-resources: The [/resources](https://lobid.org/resources) service provides bibliographic data from the hbz union catalog (approximately 20 M records) as Linked Data.

This means, lobid is serving data that is created and curated in other systems. For _transformation_ of the data from different sources we use [Metafacture](https://github.com/culturegraph/metafacture-core). While the concrete technology is not relevant for documentation, it is definitely relevant where the data comes from and that it is altered before being provided by lobid.

## Read-only JSON-LD API

So we have two services to document. These services currently are read-only, i.e. client interaction in terms of HTTP verbs is limited to GET requests. This makes the documentation of the actual API quite manageable as only few URL paths and their parameters for GET requests have to be documented.

As its underlying technology, lobid uses [Elasticsearch](https://www.elastic.co/products/elasticsearch), a Lucene-based search engine. The JSON-LD resulting from the transformation process is indexed in Elasticsearch and can be queried by anybody using the [Lucene query syntax](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html). We are offering some additional parameters in our web application – implemented with the [Play framework](https://www.playframework.com/) – to simplify specific kinds of searches.

# What to document?

Following from the description above, there are different aspects of the API and the data it provides that may be worthy of documentation. Let's take a look at them, from most to least prioritized in our documentation process.

## The data set

People not familiar with an API first want to quickly assess whether the data provided is actually of interest to them. To get a quick overview over the data set itself, you need to answer questions like: What is the data about? How up-to-date is the data? How many resources are described? How many of each type? Which specific information is available for how many resources? (For example _How many bibliographic resources actually have information about the publication date?_ or _How many organisations have geo coordinates associated with them?_)

## The API itself

For enabling interested people to make use of the lobid API, it is of greatest importance to document the API itself as the interface they interact with. Focussing on the API itself and the JSON it serves (without the "LD"), documentation is needed for:

1. the different services, the types of resources they describe and their API parameters
2. the Lucene query syntax
3. the query results, i.e. their structure as well as the JSON keys used for a specific resource type and their type of content (URIs, uncontrolled text, controlled values etc.) and whether a key can hold multiple values or only holds one

The most work definitely has to be put into 1.) and 3.), while 2.) can be covered by referring to the Lucene documentation.

## RDF vocabularies, properties & classes

With regard to the data being Linked Data, some people will be interested in the RDF vocabularies and properties/classes we use. Here, a reference to the JSON-LD context document can help (see the contexts for [lobid-organisations](http://lobid.org/organisations/context.jsonld) and [lobid-resources](http://lobid.org/resources/context.jsonld)). The question is whether this suffices as documentation of the RDF properties and classes used.

## Provenance information

Beyond the identification of the data sources, some people want to know from which concrete field in the source data a specific information is derived and what kind of post-processing is done. This is especially of interest for information professionals who are familiar with the source data sets and want to assess the lobid data. For this, some documentation of the mappings and the transformation process is needed.

In the upcoming post we will take a look at how we plan to provide documentation for the different aspects of the lobid API.
