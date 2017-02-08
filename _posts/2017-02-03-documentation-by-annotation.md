---
layout: post
title: "Documenting data by annotating examples"
date: 2017-02-03
author: Adrian Pohl
---

The relaunch of the lobid-resources and lobid-organisations API is near. This is an ideal possibility to improve our documentation – be it the for functions of the API or the structure and fields of the data retrieved via the API. We serve JSON(-LD) via our API so the different JSON fields and their type of content (URIs, uncontrolled text, controlled values etc.) have to be somehow documented so that possible API users get a basic understanding quickly.

Common practice of documenting your data, a metadata schema, an application profile is using llists and tables, often contained within a PDF. Examples:  

When I try to get an understanding of a schema and how it is used, I am soon looking out for example records . But examples are often secondary, if given at all. schema.org highly values examples in their documntation  – but often even there example are missing, for example it is hard to learn about how to use https://schema.org/publication & https://schema.org/PublicationEvent.


Short, examples are a very important and long tables listing elements of a metadata schema, their descriptions and values are rather annoying. So we started to turn this around by putting the example in the center of documentation. Or, phrasing it more provocative: [All documentation should be built around examples](https://twitter.com/acka47/status/791271448245637120).

So we did this: using production examples of our JSON data and annotating them with hypothes.is.

What are the requirements for such an approach:
- The examples taken for documentation should at best be live data from production. Thus, if something changes on the data side, the example – and with it the documentation – automatically updates.

See e.g. the documentation for the – still officially to be launched – lobid-organisations service: http://lobid.org/organisations/api/de (The German version is more comprehensive but I also added some annotations on the [English documentation page](http://lobid.org/organisations/api/en).)