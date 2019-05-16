---
layout: post
title: "Skohub: Enabling KOS-based content subscription"
date: 2019-05-15
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

For a long time, openness movements and initiatives with labels like "Open Access", "Open Educational Resources" (OER) or "Linked Science" have been working on establishing a culture where scientific or educational resources are by default published with an [open](http://opendefinition.org/) license on the web to be read, used, remixed and shared by anybody. With a growing supply of resources on the web the challenge grows to learn about or find resources relevant for your teaching, studies, or research.

In this post, we describe the Skohub project being carried out in 2019 by the hbz in cooperation with Felix Ostrowski (graphthinking) as technical lead. The project seeks to implement a prototype for a novel approach in syndicating content on the web by combining current web standards for sending notifications and subscribing to feeds with knowledge organization systems (KOS, sometimes also called "controlled vocabularies").\*

# Current practices and problems

In this paragraph we will take a brief look onto present approaches to the problem of finding open content on the web and their limitations.

## Searching metadata harvested from silos

Current approaches for publishing and finding open content on the web are often focused on repositories as the place to publish content. Those repos then provide standardized interfaces for crawlers to collect and index the metadata and offer search solutions on top. An established approach for Open Access (OA) articles goes like this:

- Repositories with interfaces for metadata harvesting ([OAI-PMH](http://www.openarchives.org/OAI/openarchivesprotocol.html)) are set up for scholars to upload their OA publications
- Metadata is crawled from repositories, normalized and loaded into search indexes
- Search interfaces are offered to end users


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/2019-05-15-skohub/repo-approach.png" alt="Diagram of the current approach with metadata being crawled from repos, indexed and search offered on top." style="width:400px">

With this approach, subject-specific filtering is either already done when crawling the data to create a subject-specific index or when searching the index.

## Maintenance burden

When offering a search interface with this approach, you have to create and maintain a list of sources to harvest which means

1. watching out for new relevant sources to be added to your list,
2. adjusting your crawler to changes regarding the services' harvesting interface,
3. homogenising data from different sources to get a consistent search index.

Furthermore, end users have to know where to find your service to search for relevant content.

## Off the web

Besides being error-prone and requiring resources for keeping up with changes in the repositories, this approach also does not take into account how web standards work. As [Van de Sompel and Nelson 2015](https://doi.org/10.1045/november2015-vandesompel) (both co-editors of the OAI-PMH specification) phrase it:

> <small>"Conceptually, we have come to see [OAI-PMH] as repository-centric instead of resource-centric or web-centric. It has its starting point in the repository, which is considered to be the center of the universe. Interoperability is framed in terms of the repository, rather than in terms of the web and its primitives. This kind of repository, although it resides on the web, hinders seamless access to its content because it does not fully embrace the ways of the web."</small>

In short, the repository metaphor guiding this practice obscures what constitutes the web: **resources** that are identified by **HTTP URIs** ([Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)).

# Topic-specific subscription to web resources

So how could a web- or resource-centric approach to resource discovery by subject look like?

## Of the web

To truly be part of the web, URIs are the most important part: Every OER needs a URL that locates and identifies the OER. If I want to make use of knowledge organization systems on the web, representing a controlled vocabulary using the [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) vocabulary while assigning each element a URI is the best way to go forward. With this prerequisites, anybody can link their resources to topics from a controlled vocabulary (for example by embedding [LRMI](http://www.dublincore.org/specifications/lrmi/lrmi_1/), "Learning Resource Metadata Initiative" metadata as JSON-LD into the resource or its description page).

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/2019-05-15-skohub/subject-indexing-with-uris.png" alt="A diagram with three resources (an OER, a subject and a classification), each identified by a URI and linked together" style="width:230px">


## Web-based subscriptions and notifications

So, HTTP URIs for educational resources and subjects are important to transparently publish and thereafter identify and link educational resources, classifications and subjects on the web. But with URIs as the basic requirement in place, we also get the possibility to utilize other web standards for the discovery of OER. For Skohub, we make use of [Social Web Protocols](https://www.w3.org/TR/social-web-protocols/) to build an infrastructure where services can send and subscribe to notifications for subjects. The general setup looks as follows:

1. Every element of a controlled vocabulary gets an inbox, identified by a URL.
<img src="/images/2019-05-15-skohub/subject-indexing-with-uris-and-inbox.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together" style="width:500px">
2. Systems can send notifications to the inbox, for example "This is a new resource about this subject".
<img src="/images/2019-05-15-skohub/sending-notification.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together plus a notification being sent from the OER to the suject's inbox" style="width:500px">
3. Systems can subscribe to a subject's inbox and will directly receive a notification as soon as it is received (push approach).
<img src="/images/2019-05-15-skohub/pushing-notification.png" alt="A diagram with four resources (an OER, a subject, an inbox, a classification), each identified by a URI and linked together plus a notification being sent from the OER to the suject's inbox" style="width:500px">

This infrastructure allows applications

1. to send a notification to a subject's inbox containing information about and a link to new content about this subject
2. to subscribe to the inbox of a subject from a knowledge organization system to receive push updates about new content in real time

Here is an example about a teacher being interested in new resources about environmental topics who subscribes to the subject via a controlled vocabulary like [ISCED-2013 Fields of Education and Training](https://unesdoc.unesco.org/ark:/48223/pf0000235049). He then receives updates whenever a colleague publishes a resource that is linked to the topic.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/2019-05-15-skohub/pubsub.png" alt="A diagram with Teacher A subscribing to a subject tag that a document published by Teacher B is about, thus receiving notifications about the new resource." style="width:300px">

To be really useful, applications for subscribing to content should enable additional filters, to subscribe to combination of subjects (e.g. "Environment" & "Building and civil engineering") or to add addtional filters on educational level, license type etc.

# Advantages

This subject-oriented notification/subscription approach to content syndication on the web has many advantages.

**Push instead of pull**
<br />
 With the push approach, you subscribe once and content is coming from different and new sources without the subscriber having to maintain a list of sources. Of course spam might become a problem. Thus, instead of whitelisting by administering a subscription list one would practice blacklisting by filtering out sources of low-quality or spam content.

**Knowledge organization systems are used to their full potential**
<br />
This additional layer to the use of Knowledge Organization Systems give them much more power ("KOS on steroids").

**Encouraging creation and use of shared Knowledge Organization Systems across applications**
<br />
In the German OER context it is a recurring theme that people are wishing everybody would use the same controlled vocabularies so that data exchange and aggregation required less mapping. With a Skohub infrastructure in place, there are big additional incentives on going forward in this direction.

**Incentive for content producers to add machine-readable descriptions**
<br />
When subject indexing becomes tantamount with notifying interested parties to their resources, this means a huge incentive for content producers to describe their resources with structured data doing subject indexing.

# Skohub scope

The Skohub project has four deliverables. While working on the backend infrastructure for receiving and pushing notifications (skohub-pubsub), we also want to provide people with means to publish a controlled vocabulary along with inbox (skohub-ssg), to link to a subject and send a notification (skohub-editor) and to subscribe to notifications in the browser (skohub-deck).

**skohub-pubsub: Inboxes and subscriptions**
<br />
Code: [https://github.com/hbz/skohub-pubsub](https://github.com/hbz/skohub-pubsub)
<br />
This part provides the Skohub core infrastructure, setting up basic inboxes for subjects plus the ability of subscribing to push subscriptions for each new notification.

**skohub-ssg: Static site generator for Simple Knowledge Organization Systems**
<br />
Code: [https://github.com/hbz/skohub-ssg](https://github.com/hbz/skohub-ssg)
<br />
This part of the project covers the need to easily publish a controlled vocabulary as SKOS file, with a basic lookup API and a nice HTML view including links to an inbox for each subject.

**skohub-editor: Describing & linking learning resources, sending notifications**
<br />
Code: [https://github.com/hbz/skohub-editor](https://github.com/hbz/skohub-editor)
<br />
The editor runs in the browser and enables ergonomic structured description of an educational resource. It includes validation of the entered content for each field and lookup of controlled values via the API provided by skohub-ssg.

**skohub-deck: Browser-based subscription to subjects**
<br />
Code: [https://github.com/hbz/skohub-deck](https://github.com/hbz/skohub-deck)
<br />
The Skohub deck is a proof of concept that the technologies developed actually work. It enables people to subscribe to notifications for specific subjects in the browser. The incoming notifications will be shown in a Tweetdeck-like interface.

# Outlook

The project will latest be completed by end of 2019. We intend to give updates about the process during the way. Next up, we will explain the technical architecture in more detail, expanding on our use of social web protocols. Furthermore, we will give updates on the development status of the project.

----

\*<small> Note, that while Skohub has clear similarities with the "Information-Sharing Pipeline" envisioned in Ilik and Koster 2019 regarding the use of social web protocols on authority data, there is also a fundamental difference: While Ilik and Koster are talking about sharing updates *of* authority entries themselves (e.g. receiving updates for a person profile to be considered for inclusion in one's own authority file), Skohub is about sending notifications *to* an entry in an authority file or other controlled vocabulary.</small>

# References

de Sompel, Herbert Van / Nelson, Michael L. (2015): Reminiscing About 15 Years of Interoperability Efforts. D-Lib Magazine 21 , no. 11/12. DOI: [10.1045/november2015-vandesompel](https://doi.org/10.1045/november2015-vandesompel)

Ilik, Violeta / Koster, Lukas (2019): Information-Sharing Pipeline, The Serials Librarian, DOI: [10.1080/0361526X.2019.1583045](https://doi.org/10.1080/0361526X.2019.1583045). Preprint: [https://doi.org/10.31219/osf.io/hbwf8](https://doi.org/10.31219/osf.io/hbwf8])
