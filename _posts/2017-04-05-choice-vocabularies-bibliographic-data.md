---
layout: post
title: "Which vocabularies to use for bibliographic descriptions?"
date: 2017-04-05
author: Christoph Ewertowski
---

Every Linked Data application builds upon vocabularies. But which ones contain the properties and classes needed for bibliographic descriptions? The topic of this blog post is how we choose specific vocabularies, properties and classes, what patterns stand behind our choices and the reasons for them.

From the very beginning of lobid (i.e. 2010), we are promoting the reuse of existing vocabularies instead of creating a new vocabulary for every application.  Only if we could not find existing properties or classes that fit our purpose and come from an existing vocabulary which looks serious and is still maintained, we would create new ones in [lobid vocab](http://purl.org/lobid/lv). We still follow this approach, although we notice that some effort is needed to keep up with changes in namespaces (looking at you, RDA!) or completely disappearing vocabularies. (Having made these experiences, we might follow another approach if we had to start from scratch today: Creating an application-specific vocabulary as you go along and aligning it with existing vocabularies later definitely makes you focus on creating a sensible data model in the first place without taking over problematic models from others.<sup>1</sup>)

For six years our used properties and classes developed rather organically and there was no well thought-out documented strategy for chosing our properties and classes. This changed when we worked on the relaunch of the lobid API. We had to add and replace a lot of properties and finally assessed all properties and classes used in lobid in order to make our application profile as consistent as possible.

For example, confronted with the question which properties to reuse for newly added information, we wrote down the following ranking of vocabularies to chose from to guide our choice:

1. [DC Terms](http://purl.org/dc/terms)
2. [Bibliograpic Ontology (Bibo)](http://bibliontology.com/)
3. [Bibframe](http://id.loc.gov/ontologies/bibframe.html)
4. [schema.org](http://schema.org/)
5. Other vocabularies like Resource Description and Access (RDA) [Unconstrained Properties](http://www.rdaregistry.info/Elements/u/) and some more [RDA](http://www.rdaregistry.info) value vocabularies et cetera.
6. [Our own vocabulary](http://purl.org/lobid/lv)

We would look for fitting properties and classes first mostly using [Linked Open Vocabularies](http://lov.okfn.org/) as search tool and then would decide which vocabularies provide things we need. If multiple vocabs have fitting properties/classes we would apply the ranking above to guide our choice.

The most important criterion for this ranking is how well a property or class can represent what we want to express / how specific it is. With too generic properties and classes no one would find what they are searching for because meaning would be lost. The estimated number of users is an important point because it indicates that a vocabulary is a mature one, won’t change too much and covers the described field of topic. A number of too many vocabularies are difficult to handle so coverage of the field of topic of bibliographies is also a point to have in mind. And it makes a difference if they are maintained regularly with preferably no changes in the URLs or even namespace.  

To go more into detail: DC is at the first place, simply because it’s a widely adopted standard for basic information about resources. Bibframe contains many properties to describe bibliographic resources which also can be seen in the goal “to evolve bibliographic description standards to a linked data model“ ([source](http://www.loc.gov/bibframe/docs/bibframe2-model.html)). Since it’s relatively new it is maintained actively and changes could be discussed with the developing institutions. Schema.org isn’t concentrated on library resources at all but covers a lot of properties we need. And since it is backed by big internet firms it also used by a lot of domains (for example 100.000-250.000 for the property ```[startDate](https://schema.org/startDate)``` according to schema.org). After these vocabularies less used ones are selected for how good they represent what we want to express. And following good practice we only use our own vocabulary if we find no alternative or such which seem to be taken offline in the next months. This vocabulary can be found at http://purl.org/lobid/lv and is maintained at [GitHub](https://github.com/hbz/lobid-vocabs/blob/master/lobid-vocab.ttl). For convenience it is written in turtle.

If you have comments or suggestions for improvement, we would be interested to hear them. 

<sup>1</sup> Such an approach was taken developing the [ls.ext](https://github.com/digibib/ls.ext) library system for Deichman Library, Oslo. Rurik Greenall has promoted this strategy a lot, e.g. in his [ELAG2015 talk](https://github.com/brinxmat/presentations/blob/master/2015/ELAG2015.pdf). 