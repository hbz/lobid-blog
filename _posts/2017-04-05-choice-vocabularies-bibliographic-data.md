---
layout: post
title: "Which vocabularies to use for bibliographic descriptions?"
date: 2017-04-05
author: Christoph Ewertowski
---

Every Linked Data application builds upon vocabularies. But which ones contain the properties and classes needed for bibliographic descriptions? The topic of this blog post is how we choose specific vocabularies, properties and classes for [lobid-resources](http://lobid.org/resources), what patterns stand behind our choices and the reasons for them.

# A grown application profile

In the very beginning of lobid (i.e. 2010) one specific bibliographic RDFS vocabulary or OWL ontology that catered for all our need did not exist. This is even more true today as our Linked Data publication carries much more information than some years ago. Thus, we either needed to create our own ontology or create an application profile based on a number of different vocabularies. We opted for vocabulary reuse as this approach promised to increase interoperability with other linked data sets <sup>1</sup>. Only if we could not find existing properties or classes that fit our purpose and come from an existing vocabulary which looks serious and is still maintained, we would create new ones in [lobid vocab](http://purl.org/lobid/lv). We still follow this approach, although we notice that some effort is needed to keep up with changes in namespaces (looking at you, RDA!) or completely disappearing vocabularies. (Having made these experiences, we might follow another approach if we had to start from scratch today: Creating an application-specific vocabulary as you go along and aligning it with existing vocabularies later definitely makes you focus on creating a sensible data model in the first place without taking over problematic models from others.<sup>2</sup>)

For six years our used properties and classes developed rather organically and there was no well thought-out, documented strategy for chosing our properties and classes. This changed when we worked on the relaunch of the lobid API. We had to add and replace a lot of properties and finally assessed all properties and classes used in lobid in order to make our application profile as consistent as possible.

# Assessing elements and vocabularies for reuse

For adding labels and variant names of a resource, we chose the `rdfs:label` and `skos:altLabel` as RDFS and SKOS are two widely-used base vocabularies. Typing of linked entities from the Integrated Authority File (GND) is done using the [GND Ontology](http://d-nb.info/standards/elementset/gnd). Confronted with the question which properties to use for other data elements, we wrote down the following ranking of vocabularies to guide our choice:

1. [DC Terms](http://purl.org/dc/terms)
2. [Bibframe](http://id.loc.gov/ontologies/bibframe.html)
3. [Bibliograpic Ontology (Bibo)](http://bibliontology.com/)
4. [schema.org](http://schema.org/)
5. Resource Description and Access (RDA) [Unconstrained Properties](http://www.rdaregistry.info/Elements/u/)
6. Several other vocabularies (MADS, Music Ontology, DC Elements, FOAF,...) for individual elements
6. [Our own vocabulary](http://purl.org/lobid/lv)

The workflow for finding the right thing to reuse goes as follows: We first look for fitting properties and classes mostly using [Linked Open Vocabularies](http://lov.okfn.org/) as search tool and identify which vocabularies provide things specific enough for our purposes. If multiple vocabs have fitting properties/classes we apply the ranking above to make our choice.

The ranking takes into account different aspects of vocabularies, like: How mature is the vocabulary? Is it well known and does it have a considerable user group? How stable is a vocabulary? Criteria for exclusion are whether vocabulary URIs actually resolve and deliver RDF.  The question how user-friendly a vocabulary interface is doesn't weigh much, though, as actually most vocabularies currently have a suboptimal UI (including and especially our own vocab which is served as plain Turtle)? 

To get into more detail: DC is at the first place, simply because it’s a widely adopted standard for basic information about resources. Bibframe might not be seen as a very stable vocabulary yet. However, it has given us the opportunity to model a lot of things the way we needed to (e.g. with its contribution/role approach, see [this comment](https://github.com/hbz/lobid-resources/issues/38#issuecomment-259084607)). We believe that Bibframe will be more stable with the current version 2.0 and as a lot of institutions will probably use it in the future we also just wanted to get familiar with it. Since it still is in development, changes can be proposed as needed. 

Though we rely on Schema.org as base vocabulary in [lobid-organisations](http://lobid.org/organisations), we sticked to DC, Bibo et al. in the context of bibliographic resources. We [intend](https://github.com/hbz/lobid-resources-web/issues/25) to publish schema.org markup embedded in the HTML later for use by search engines etc. But schema.org already convinced us as the only vocabulary to provide an easy way of an event-based modeling of publication information, see e.g. the "publication" object in [this example file](http://lobid.org/resources/HT002213253?format=json).

When the information to be expressed in RDF gets more and more library-specific the RDA Unconstrained Vocabularies can often help out. Thus, we use it for things like thesis information, title of subseries or RDA specific information like nature of content.

Some information is covered by using different other sources, for example using MADS for representing [complex subjects](https://github.com/hbz/lobid-resources/issues/187) or Music Ontology for typing sheet music. 

Finally, we create properties and classes in our own _lobid-vocab_ if other relevant vocabularies don't resolve properly or aren't available in RDF or if there is no existing vocabulary providing the necessary means at all. This was for example the case when associating isPartOf relations of a resource to a series or multi-volume work with the volume number (https://github.com/hbz/lobid-vocabs/issues/39) or when expressing dataset-specific information like the internal identifier. lobid-vocab can be found at http://purl.org/lobid/lv and is maintained on [GitHub](https://github.com/hbz/lobid-vocabs/blob/master/lobid-vocab.ttl). For convenience it is written in turtle.

If you have comments or suggestions for improvement, we would be interested to hear them. 

<sup>1</sup> This benefit hasn't manifested itself yet, although we also have contributed to the [Gruppe Titeldaten der DINI-AG KIM](https://wiki.dnb.de/display/DINIAGKIM/Titeldaten+Gruppe)'s work on defining a common application profile for Linked Library Data in German-speaking countries.

<sup>2</sup> Such an approach was taken developing the [ls.ext](https://github.com/digibib/ls.ext) library system for Deichman Library, Oslo. Rurik Greenall has promoted this strategy a lot, e.g. in his [ELAG2015 talk](https://github.com/brinxmat/presentations/blob/master/2015/ELAG2015.pdf). 