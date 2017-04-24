---
layout: post
title: "Documenting the lobid API, part II: How to document?"
date: 2017-02-03
author: Adrian Pohl
---
As outlined in the [part I](http://blog.lobid.org/2017/02/23/api-documentation-1.html), there are different aspects of an API you need to take into account when working on the documentation: the data set as a whole, the API calls and response structurem RDF properties and classes, provenance information. In this post I want to share how we approached their documentation.

# High-level documentation of the dataset

To give persons (as well as machines) a quick overview over the dataset that is provided via the API, we mostly followed the W3C's [Data on the Web Best Practices recommendation](https://www.w3.org/TR/dwbp/#metadata). The result is a [JSON-LD file](http://lobid.org/organisations/dataset.jsonld) describing the dataset as well as a human-readable [HTML version](http://lobid.org/organisations/dataset) of the same information. Note that we decided to use schema.org properties and classes where possible instead of DC Terms as suggested in the W3C recommendation.

| ![Description of the lobid-organisations data set](/images/lobid-organisations-description.png) |
|:---:|
| HTML-version of the lobid-organisations data set description |

# Documenting API, data structure & application profile

When I try to get an understanding of a schema and how it is used, I quickly find myself looking out for example records. But examples are often secondary parts of documentations, if given at all. Common practice of documenting a vocabulary or an application profile is using lists and tables, often contained within a PDF.
schema.org for example in contrast to other vocabularies highly values examples – but often even there examples are missing. (E.g. it is hard to learn about how to use [the `publication` property](https://schema.org/publication) & the [publication event class](https://schema.org/PublicationEvent).)

I believe that examples should be an integral part of documentation while I deem page-long tables listing elements of a metadata schema as rather annoying. So we started to turn this around by putting the example in the center of documentation following the bold claim that ""[All documentation should be built around examples](https://twitter.com/acka47/status/791271448245637120)".

A [post on API documentation from 2010](https://www.programmableweb.com/news/web-api-documentation-best-practices/2010/08/12) claims:

> In addition to sample code, having HTTP, XML, and JSON samples of your request and response is important. However, samples only are not sufficient. In addition, you need a description that explains the purpose of the call and you need a table that explains each element. We recommend a table with columns for Name, Type, Description, and Remarks.

With web annotation you can now have both: examples and a structured annotation of specific parts of it. So we did this: using production examples of our JSON data and annotating them with hypothes.is.

We chose to annotate each JSON key with the following information:

- Name
- Description
- Coverage
- Use cases
- Provenance
- URI

What are the requirements for such an approach:
- The examples taken for documentation should at best be live data from production. Thus, if something changes on the data side, the example – and with it the documentation – automatically updates.

See e.g. the documentation for the – still officially to be launched – lobid-organisations service: http://lobid.org/organisations/api/en

----

Questions:

- Should we add "type" information to the annotations in lobid?
- Should we add a query template to each field annotation, e.g. for contribution.agent.id: https://lobid.org/resources/search?q=contribution.agent.id:{GND-ID}