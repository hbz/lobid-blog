---
layout: post
title: "Which vocabularies to use for bibliographic descriptions?"
date: 2017-04-05
author: Christoph Ewertowski
---

Every Linked Data application builds upon vocabularies. But which ones contain the properties and classes needed for bibliographic descriptions? The topic of this blog post will be how we choose specific vocabularies, properties and classes, what patterns stand behind it and the reasons for them.

Over some time our used properties and classes developed organically and there was no conscious choice about new properties and classes. This changed when we became aware of many deprecated properties (looking at you, RDA!) and went to all our used properties and classes. Confronted with the question which replacements to use instead we thought about if there was a pattern already and if it would be the right one. At the end we wrote down the following ranking for our usage of vocabularies:

1. Dublin Core (DC). Mainly [DC Terms](http://purl.org/dc/terms) but also [DC Elements](http://purl.org/dc/elements/1.1/).
2. [Bibframe](http://id.loc.gov/ontologies/bibframe.html)
3. [schema.org](http://schema.org/)
4. Other vocabularies like Resource Description and Access ([RDA](http://www.rdaregistry.info)), International Standard Bibliographic Description ([ISBD](http://iflastandards.info/ns/isbd/terms)), et cetera.
5. [Our own vocabulary](http://purl.org/lobid/lv)

The most important criterion for this ranking is how well a property or class can represent what we want to express / how specific it is. With too generic properties and classes no one would find what they are searching for because meaning would be lost. The estimated number of users is an important point because it indicates that a vocabulary is a mature one, won’t change too much and covers the described field of topic. A number of too many vocabularies are difficult to handle so coverage of the field of topic of bibliographies is also a point to have in mind. And it is makes are difference if they are maintained regularly with preferably no changes in the URLs or even namespace.  

To go more into detail: DC is at the first place, simply because it’s a widely adopted standard for basic information about resources. Bibframe contains many properties to describe bibliographic resources which also can be seen in the goal “to evolve bibliographic description standards to a linked data model“ ([source](http://www.loc.gov/bibframe/docs/bibframe2-model.html)). Since it’s relatively new it is maintained actively and changes could be discussed with the developing institutions. Schema.org isn’t concentrated on library resources at all but covers a lot of properties we need. And since it is backed by big internet firms it also used by a lot of domains (for example 100.000-250.000 for the property ```[startDate](https://schema.org/startDate)``` according to schema.org). After these vocabularies less used ones are selected for how good they represent what we want to express. And following good practice we only use our own vocabulary if we find no alternative or such which seem to be taken offline in the next months. This vocabulary can be found at http://purl.org/lobid/lv and is maintained at [GitHub](https://github.com/hbz/lobid-vocabs/blob/master/lobid-vocab.ttl). For convenience it is written in turtle.

If you have comments or suggestions for improvement, we would be interested to hear them. 
