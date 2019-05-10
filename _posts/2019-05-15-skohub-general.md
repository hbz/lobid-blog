---
layout: post
title: "Skohub: Infrastructure for knowledge-organization-based content syndication"
date: 2019-05-15
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

alternative titles:
- "Skohub: Subscribing to content updates via knowledge organization systems"
- "Skohub: Knowledge-organization-based content subscription"
- "Skohub: Enabling authority-based content subscription"

For a long time, openness movements and initiatives with labels like "Open Access", "Open Educational Resources" or "Linked Science" have been working on establishing a culture where scientific or educational resources are by default published with an [open](http://opendefinition.org/) license on the web to be read, used, remixed and shared by anybody. With a growing supply of respources on the web the challenge grows to learn about or find resources relevant for your teaching, studies, or research.

# Current practices and problems

## Searching metadata harvested from silos

An established approach from the library world looks like this:

- Repositories with interfaces for metadata harvesting ([OAI-PMH](http://www.openarchives.org/OAI/openarchivesprotocol.html)) are set up for scholars to upload their OA articles
- Metadata is crawled from repositories and loaded into search indexes
- Search interfaces are offered to end users

## Maintenance burden

For offering a search interface you have to create and maintain a list of sources to harvest which means

1. watching out for new relevant sources to be added to your list,
2. adjust your crawler to changes regarding the services' harvesting interface,
3. homogenise data from different sources to get a consistent search index.

Furthermore, end users have to know where to search for relevant content.

## Off the web

Besides being error-prone and requiring resources for keeping up with changes in the repositories, this approach also does not take into account how web standards work. As [Van de Sompel and Nelson 2015](https://doi.org/10.1045/november2015-vandesompel) (both are co-editors of the OAI-PMH specification) phrase it:

> Conceptually, we have come to see [OAI-PMH] as repository-centric instead of resource-centric or web-centric. It has its starting point in the repository, which is considered to be the center of the universe. Interoperability is framed in terms of the repository, rather than in terms of the web and its primitives. This kind of repository, although it resides on the web, hinders seamless access to its content because it does not fully embrace the ways of the web.

In short, the repository metaphor obscures what constitutes the web: **resources** that are identified by **HTTP URIs**.

# Topic-specific subscription to web resources

So how could a web- or resource-centric approach to resource discovery look like?

# Advantages

- Knowledge organization systems are used to their full potential
- Content producers are incited to describe their resources using structured data and KOS
- Push instead of pull: content is coming in and you don't have to know beforehand where to look. Blacklisting instead of whitelisting.

# References

de Sompel, Herbert Van / Nelson, Michael L. (2015): Reminiscing About 15 Years of Interoperability Efforts. D-Lib Magazine 21 , no. 11/12. DOI: [https://doi.org/10.1045/november2015-vandesompel](10.1045/november2015-vandesompel)
