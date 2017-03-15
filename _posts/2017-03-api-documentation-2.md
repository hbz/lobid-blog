---
layout: post
title: "Documentation by annotation"
date: 2017-02-03
author: Adrian Pohl
---
As outlined in the [previous post](http://blog.lobid.org/2017/02/23/api-documentation-1.html), there are different aspects of your API you need to take into account when working on the documentation. In this post I want to share how we carried out the documentation of the lobid API.

# High-level documentation of the dataset

To give persons (as well as machines) a quick overview over the dataset that is provided via the API, we mostly followed the W3C's [Data on the Web Best Practices recommendation](https://www.w3.org/TR/dwbp/#metadata). The result is a [JSON-LD file](http://lobid.org/organisations/dataset.jsonld) as well as a human-readable [HTML version](http://lobid.org/organisations/dataset) of the same information describing the dataset. You may notice that we decided to use schema.org properties and classes where possible instead of DC Terms and  [DCAT](http://www.w3.org/ns/dcat) vocabulary as suggested in the W3C recommendation.



In Common practice of documenting your data, a metadata schema, an application profile is using llists and tables, often contained within a PDF. Examples:  

When I try to get an understanding of a schema and how it is used, I am soon looking out for example records . But examples are often secondary, if given at all. schema.org highly values examples in their documntation  – but often even there example are missing, for example it is hard to learn about how to use https://schema.org/publication & https://schema.org/PublicationEvent.


Short, examples are a very important and long tables listing elements of a metadata schema, their descriptions and values are rather annoying. So we started to turn this around by putting the example in the center of documentation. Or, phrasing it more provocative: [All documentation should be built around examples](https://twitter.com/acka47/status/791271448245637120).

So we did this: using production examples of our JSON data and annotating them with hypothes.is.

What are the requirements for such an approach:
- The examples taken for documentation should at best be live data from production. Thus, if something changes on the data side, the example – and with it the documentation – automatically updates.

See e.g. the documentation for the – still officially to be launched – lobid-organisations service: http://lobid.org/organisations/api/de (The German version is more comprehensive but I also added some annotations on the [English documentation page](http://lobid.org/organisations/api/en).)



----

From https://www.programmableweb.com/news/web-api-documentation-best-practices/2010/08/12:

> In addition to sample code, having HTTP, XML, and JSON samples of your request and response is important. However, samples only are not sufficient. In addition, you need a description that explains the purpose of the call and you need a table that explains each element. We recommend a table with columns for Name, Type, Description, and Remarks.

Questions:

- Should we add "type" information to the annotations in lobid?
- Add the corresponding URI to each field?
- Should we add a query template to each field annotation, e.g. for contribution.agent.id: https://lobid.org/resources/search?q=contribution.agent.id:{GND-ID}