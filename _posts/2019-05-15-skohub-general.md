---
layout: post
title: "Skohub: Enabling authority-based content subscription"
date: 2019-05-15
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

alternative titles:

- "Skohub: Subscribing to content updates via knowledge organization systems"
- "Skohub: Knowledge-organization-based content subscription"
- "Skohub: Enabling authority-based content subscription"
- "Skohub: Infrastructure for knowledge-organization-based content syndication"

For a long time, openness movements and initiatives with labels like "Open Access", "Open Educational Resources" (OER) or "Linked Science" have been working on establishing a culture where scientific or educational resources are by default published with an [open](http://opendefinition.org/) license on the web to be read, used, remixed and shared by anybody. With a growing supply of respources on the web the challenge grows to learn about or find resources relevant for your teaching, studies, or research.

In this post, we describe a novel approach in syndicating content on the web, combining knowledge organization systems (also called "controlled vocabularies") like authority files or classifications with current web standards for sending notifications and subscribing to feeds.

# Current practices and problems

In this paragraph we will take a brief look onto the approach to the problem of finding open content on the web and its limitations.

## Searching metadata harvested from silos

Current approaches for publishing and finding open content on the web are often focused on repositories as the place to publish content. Those repos then provide standardized interfaces for crawlers to collect and index the metadata and offer search solutions on top. An established approach for Open Access (OA) articles goes like this:

- Repositories with interfaces for metadata harvesting ([OAI-PMH](http://www.openarchives.org/OAI/openarchivesprotocol.html)) are set up for scholars to upload their OA publications
- Metadata is crawled from repositories and loaded into search indexes
- Search interfaces are offered to end users


<img src="/images/2019-05-15-skohub/repo-approach.png" alt="Diagram of the current approach with metadata being crawled from repos, indexed and search offered on top." style="width:400px">

Subject-specific filtering is either already done when crawling the data to create a subject-specific index or when searching the index.

## Maintenance burden

When offering a search interface with this approach, you have to create and maintain a list of sources to harvest which means

1. watching out for new relevant sources to be added to your list,
2. adjust your crawler to changes regarding the services' harvesting interface,
3. homogenise data from different sources to get a consistent search index.

Furthermore, end users have to know where to find your service to search for relevant content.

## Off the web

Besides being error-prone and requiring resources for keeping up with changes in the repositories, this approach also does not take into account how web standards work. As [Van de Sompel and Nelson 2015](https://doi.org/10.1045/november2015-vandesompel) (both are co-editors of the OAI-PMH specification) phrase it:

> "Conceptually, we have come to see [OAI-PMH] as repository-centric instead of resource-centric or web-centric. It has its starting point in the repository, which is considered to be the center of the universe. Interoperability is framed in terms of the repository, rather than in terms of the web and its primitives. This kind of repository, although it resides on the web, hinders seamless access to its content because it does not fully embrace the ways of the web."

In short, the repository metaphor obscures what constitutes the web: **resources** that are identified by **HTTP URIs** ([Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)).

# Topic-specific subscription to web resources

So how could a web- or resource-centric approach to resource discovery by subject look like?

## Of the web

To truly be part of the web, URIs are the most important part: Every OER needs a URL that locates and identifies the OER. If I want to make use of knowledge organization systems on the web, representing a controlled vocabulary using the [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) vocabulary while assigning each element a URI is the best way to go forward. With this prerequisites, anybody can link their resources to topics from a controlled vocabulary (for example by embedding [LRMI](http://www.dublincore.org/specifications/lrmi/lrmi_1/) ("Learning Resource Metadata Initiative") metadata as JSON-LD into the resource or its description page).

<img src="/images/2019-05-15-skohub/subject-indexing-with-uris.png" alt="A diagram with three resources (an OER, a subject and a classification), each identified by a URI and linked together" style="width:300px">


## Web-based subscriptions and notifications

So, HTTP URIs for educational resources and subjects are important to identify and link educational resources, classifications and subjects on the web. But with URIs as the basic requirement in place, we also get the possibility to utilize other web standards for the discovery of OER. For Skohub, we make use of [Linked Data Notifications](https://www.w3.org/TR/ldn/) and [Websub](https://www.w3.org/TR/websub/) to build an infrastructure where services can send and subscribe to notifications for subjects. The general setup looks as follows:

1. Every element of a controlled vocabulary gets an inbox, that also gets a URL.
<img src="/images/2019-05-15-skohub/subject-indexing-with-uris-and-inbox.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together" style="width:500px">
2. Systems can send notifications to the inbox, for example "This is a new resource about this subject".
<img src="/images/2019-05-15-skohub/sending-notification.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together plus a notification being sent from the OER to the suject's inbox" style="width:500px">
3. Systems can subscribe to a subject's inbox and will directly receive a notification as soon as it is received (push approach).
<img src="/images/2019-05-15-skohub/pushing-notification.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together plus a notification being sent from the OER to the suject's inbox" style="width:500px">

## Advantages

- Knowledge organization systems are used to their full potential
- Content producers are incited to describe their resources using structured data and KOS
- Push instead of pull: content is coming in and you don't have to know beforehand where to look. Blacklisting instead of whitelisting.

# Scope of the Skohub project

The Skohub project has four deliverables

## skohub-pubsub: Inboxes and subscriptions

## skohub-ssg: Static site generator for Simple Knowledge Organization Systems

## skohub-editor: Describing & linking learning resources, sending notifications

## skohub-deck: Browser-based subscription to subjects


# References

de Sompel, Herbert Van / Nelson, Michael L. (2015): Reminiscing About 15 Years of Interoperability Efforts. D-Lib Magazine 21 , no. 11/12. DOI: [https://doi.org/10.1045/november2015-vandesompel](10.1045/november2015-vandesompel)
