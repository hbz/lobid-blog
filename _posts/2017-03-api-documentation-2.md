---
layout: post
title: "Documenting the lobid API, part II: How to document?"
date: 2017-02-03
author: Adrian Pohl
---
As outlined in the [part I](http://blog.lobid.org/2017/02/23/api-documentation-1.html), there are different aspects of an API you need to take into account when working on the documentation: the data set as a whole, the API calls and response structurem RDF properties and classes, provenance information. In this post I want to share how we approached their documentation.

# High-level documentation of the dataset

To give persons (as well as machines) a quick overview over the dataset that is provided via the API, we mostly followed the W3C's [Data on the Web Best Practices recommendation](https://www.w3.org/TR/dwbp/#metadata). The result is a [JSON-LD file](http://lobid.org/organisations/dataset.jsonld) describing the dataset as well as a human-readable [HTML version](http://lobid.org/organisations/dataset) of the same information. Note that we decided to use schema.org properties and classes where possible instead of DC Terms as suggested in the W3C recommendation.

![Description of the lobid-organisations data set](/images/lobid-organisations-description.png) 

HTML-version of the lobid-organisations data set description

# Documenting the API

The API documentation (see http://lobid.org/organisations/api/en as reference):

- example queries
- query nested fields
- escaping URIs
- location-based queries
- refer to Lucene quer string syntac documentation
- content types
- non-ES-built-in:
  - csv export
  - auto-complete
- Open refine reconciliation endpoint

## Documentation by example: data structure, application profile, provenance

When I try to get an understanding of a schema and how it is used, I quickly find myself looking out for examples. But examples are often secondary parts of documentations, if given at all. It is common practice to use what can be called a "descriptive approach" of documenting a vocabulary or an application profile by listing elements in tables – often contained within a PDF – and describing their different aspects in various columns.

schema.org is an exception in that it tries to provide examples. But even in schema.org the examples are an appendix to the description and sometimes even missing (e.g. it is hard to learn about how to use [the `publication` property](http://schema.org/publication) & the [publication event class](http://schema.org/PublicationEvent)).

I believe that examples should be an integral part of documentation while I deem page-long tables listing elements of a metadata schema as not very helpful and rather annoying. So we thought about how to put the example in the center of documentation following the bold claim that "[All documentation should be built around examples](https://twitter.com/acka47/status/791271448245637120)".

## Using web annotation tools for API documentation

A [post on API documentation from 2010](https://www.programmableweb.com/news/web-api-documentation-best-practices/2010/08/12) says about examples:

> In addition to sample code, having HTTP, XML, and JSON samples of your request and response is important. However, samples only are not sufficient. In addition, you need a description that explains the purpose of the call and you need a table that explains each element. We recommend a table with columns for Name, Type, Description, and Remarks.

Agreed, that samples alone are not sufficient, but do I really need a table describing each element of you data? When putting the example first, why not attach the structured descriptive data (name, description, etc.) to the example? It is quite easy to achieve with web annotation tools. So we took production examples of our JSON-LD data and annotated them with [hypothes.is](https://hypothes.is/).

We chose to annotate each JSON key adding the following information:

- Name
- Description
- Coverage
- Use cases
- URI
- Provenance

At http://lobid.org/organisations/api/en you can see documentation by annotation in action. <sup>1</sup> Just go to the [JSON-LD section](http://lobid.org/resources/api#jsonld) and click on one of the highlighted JSON keys. The hypothes.is side bar will open with information about the data element.

What are the requirements for such an approach:
- The examples taken for documentation should at best be live data from production. Thus, if something changes on the data side, the example – and with it the documentation – automatically updates.<sup>2</sup>

See e.g. the documentation for the – still officially to be launched – lobid-organisations service: http://lobid.org/organisations/api/en

Another benefit is that API users can easily ask questions regarding specific parts of the documentation by replying to a hypothes.is annotation.

----

sup>1</sup> There also is a [German version](http://lobid.org/organisations/api/de) & the [lobid-resources documentation](http://lobid.org/resources/api) solely exists in German.

<sup>2</sup> At first we planned to directly annotate the JSON filesbut this only works with the Chrome plugin. Hypothes.is' [via service](https://via.hypothes.is/)does [not support annotation of text files](https://github.com/hypothesis/via/issues/79) and you also can not include JavaScript in a JSON document. Thus, we decided to embed the JSON files in a HTML page adding the hypothes.is script to the page.

Questions:

- Should we add "type" information to the annotations in lobid?
- Should we add a query template to each field annotation, e.g. for contribution.agent.id: https://lobid.org/resources/search?q=contribution.agent.id:{GND-ID}