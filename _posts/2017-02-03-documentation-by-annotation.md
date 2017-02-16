---
layout: post
title: "Documenting data by annotating examples"
date: 2017-02-03
author: Adrian Pohl
---

What is being documented?
- the data structure / data model
- the data set (e.g. by indicating coverage of a specific information/field in the data set)
- the API

The relaunch of the lobid-resources and lobid-organisations API is near. This is an ideal possibility to improve our way of documentation – be it the functions of the API or the structure and fields of the data retrieved via the API. We serve JSON(-LD) via our API so the different JSON fields and their type of content (URIs, uncontrolled text, controlled values etc.) has to somehow be documented.

Common practice of documenting your data, a metadata schema, an application profile is using tables, often contained within a PDF. See for example the ... 

When I try to get an understanding of a schema and how it is used, I am soon looking out for example records . But examples are often secondary, if given at all. schema.org tries to have examples every – but often even there example are missing --> add example: https://schema.org/publication & https://schema.org/PublicationEvent

Given that examples are a very important and long tables listing elements of a metadata schema, their descriptions and values are rather annoying, we started about turning it around and put the example in the center of documentation. Phrasing it more provocative. [All documentation should be built around examples](https://twitter.com/acka47/status/791271448245637120).

So we did this: using production examples of our JSON data and annotating them with hypothes.is.

What are the requirements for such an approach:
- The examples taken for documentation should at best be live data from production. Thus, if something changes on the data side, the example – and with it the documentation – automatically updates.

See e.g. the documentation for the – still officially to be launched – lobid-organisations service: http://lobid.org/organisations/api/de (The German version is more comprehensive but I also added some annotations on the [English documentation page](http://lobid.org/organisations/api/en).)



----

From https://www.programmableweb.com/news/web-api-documentation-best-practices/2010/08/12:

> In addition to sample code, having HTTP, XML, and JSON samples of your request and response is important. However, samples only are not sufficient. In addition, you need a description that explains the purpose of the call and you need a table that explains each element. We recommend a table with columns for Name, Type, Description, and Remarks.

Questions:

- Should we add "type" information to the annotations in lobid?
- Should we add a query template to each field annotation, e.g. for contribution.agent.id: https://lobid.org/resources/search?q=contribution.agent.id:{GND-ID}