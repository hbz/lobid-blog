---
title: "How we built a spatial subject classification based on Wikidata"
author: Adrian Pohl
---

## Background

The North-Rhine Westphalian Bibliography (NWBib) is a regional bibliography that records literature about the German state of [North-Rhine Westphalia](https://en.wikipedia.org/wiki/North_Rhine-Westphalia) (NRW), its regions, places and people. As of now, NWBib comprises more than 440,000 resources.  In addition to monographs, NWBib collects articles, as well as other media like maps, DVDs, etc. The cataloging takes place in the hbz union catalog that currently runs on Aleph (and is currently in the process of being replaced by Alma). The public interface for end users is the bibliography's website at [https://nwbib.de](https://nwbib.de). At its core, nwbib.de is a web application built on the [lobid-resources API](https://lobid.org/resources/api). To offer the hbz union catalogue as Linked Open Usable Data (LOUD), the data is exported from Aleph and transformed to JSON-LD.

In 2019 and 2020 we carried out a project to upgrade spatial subject indexing in NWBib from using uncontrolled strings to using controlled values from a spatial classification that is created from Wikidata. This article gives an overview over what we have achieved and how.

## The result

Since the beginning of 2020, the NWBib's spatial classification – which can be browsed at [https://nwbib.de/spatial](https://nwbib.de/spatial) – has been comprising around 4,500 places or geographic areas. The underlying structured data is stored as an RDF/Turtle file using the Simple Knowledge Organization System (SKOS): [https://nwbib.de/spatial.ttl](https://nwbib.de/spatial.ttl). This SKOS file in turn is for the utmost part derived from Wikidata. The Wikdiata entries which are used in NWBib can be identified by usage of the NWBib ID property `P6814`, see this SPARQL query: [https://w.wiki/3C2p](https://w.wiki/3C2p). Places that – for whatever reason – can not be loaded from Wikidata are stored in a separate SKOS file which is used together with the Wikidata entries to create the complete SKOS classification.

### Cataloging

As noted, cataloging is taking place in Aleph, so we somehow had to establish a process for cataloguers to easily add the controlled values into the bibliographic records. Thus, we have added a hidden copy button behind every classification entry to get the needed Aleph format with one click. One has to hover over the space behind a classification entry to make the button and an explaining tooltip visible, then click the button, select the correct field in Aleph and paste the entry there:

<img src="/images/nwbib-wikidata/copy2aleph.png" alt="Hidden button in the NWBib classification to copy Aleph format for cataloging" style="width:600px">

For example, a click on the button as shown in the screenshot adds the following string to the clipboard:

`Köln$$0https://nwbib.de/spatial#Q365`

The resulting catalog data looks like this (an an XML-based export format):

```xml
<datafield tag="700" ind1="n" ind2="1">
  <subfield code="a">Köln</subfield>
  <subfield code="0">https://nwbib.de/spatial#Q365</subfield>
</datafield>
```

### Updating the classification

With this approach the following process for updating the classification could be implemented. It enables direct use of a newly added place in the cataloging process:
1. NWBib editor decides to add or edit a place. They add a `P6814` statement to the respective Wikidata entry (which might have to be created from scratch for some places).
2. Editor clicks a button in the test system to trigger a new build of the classification.
3. Editor can now use the test classification for copying the entry into Aleph as described above.
4. If everything is fine on test, editor notifies the Open Inftrastructure (OI) team via email to update the classification on production.
5. OI team updates the classification in the production system and consults editors if possible undesired changes occured in Wikidata.

### Assessment

Both the people responsible for cataloging and the development team are very pleased with the results of the project and the achieved possibilities of maintaining and using a rather big spatial classification. In the rest of the text, we will outline the implementation and point out problems we ran into and decisions we had to make.

## Division of technical and editorial NWBib work

Before diving deeper into the actual project, a short explainer on how the technical and editorial work is divided between different people and institutions. NWBib editors are working at the University and State Libraries Düsseldorf and Münster while the whole underlying technical infrastructure (from cataloging to the web presence of NWBib) is managed by hbz which mostly means: the Open Infrastructure team (of which the author of this article is a member).

## NWBib as part of hbz union catalogue

NWBib editors use our Aleph union catalog for cataloguing, which means that NWBib records are also part of [lobid-resources](https://lobid.org/resources), a LOD-based web API for the union catalogue, at its core consiting of JSON-LD indexed in Elasticsearch. (See [all blog posts about lobid-resources](https://blog.lobid.org/tags/lobid-resources.)) Within lobid-resources, all NWBib titles are marked like this:

```json
{
  "inCollection" : [ {
    "id" : "http://lobid.org/resources/HT014176012#!",
    "type" : [ "Collection" ],
    "label" : "Nordrhein-Westfälische Bibliographie (NWBib)"
  } ]
}
```

This information enables to easily query NWBib data via lobid-resources by attaching [`inCollection.id:"http://lobid.org/resources/HT014176012#!"`](https://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22) to a lobid-resources query.

Basically, this is utilized to offer the web interface for NWBib at [https://nwbib.de](https://nwbib.de).

## Spatial subject indexing without controlled values

For years, subject indexing in NWBib has been done mainly by adding to a record the text strings of places the recources is about. It looked like this in the source data (see this [ZDB example](https://github.com/hbz/nwbib/wiki/Aktualisierung-der-NWBib-Systematik-Daten-in-der-ZDB#beispiel) to see how it looks in MARC21):

```xml
<datafield tag="700" ind1="n" ind2="1">
  <subfield code="a">99</subfield>
  <subfield code="b">Duisburg</subfield>
</datafield>
<datafield tag="700" ind1="n" ind2="1">
  <subfield code="a">99</subfield>
  <subfield code="b">Essen</subfield>
</datafield>
```

The strings "Duisburg" and "Essen" refer to the cities in NRW with this name. Around three quarters of NWBib records (~300,000 records) contained one or more of these place name strings. In 2017, we had 8,800 distinct strings for places which referred mostly to administrative areas but also to monasteries, principalities, natural regions etc.

## 1st phase: Enriching strings with geo coordinates

For years (2014-2019), we have been using Wikidata to enrich NWBib with geo coordinates by matching those place strings to Wikidata items and pulling the geo coordinates from there. We chose a rather naive matching approach which resulted in poor or no matches for some resources. However, it was good enough to enable map-based filtering of results at nwbib.de.

Besides the sub-optimal matching there were other drawbacks with this approach. Of course the well-known problem occured, which everybody encounters after some time when using strings instead of controlled values: you get lots of different strings for the same place because of different recording practices or typos. As said, in 2017 NWBib included around 8,800 distinct spatial strings which roughly referred to only 4,500 different places. Taking a look at a [2017 list containing all the distinct place name strings found in NWBib including an occurence count](https://gist.github.com/acka47/ccd3715201442e8cb78c70cca9ebd1ab), for example you find five strings referring to Wiesdorf, a part of Leverkusen:

- "Wiesdorf"
- "Wiesdorf &lt;Niederrhein&gt;"
- "Wiesdorf, Niederrhein"
- "Leverkusen-Wiesdorf"
- "Leverkusen- Wiesdorf (Niederrhein)"

Another drawback of the string-based approach was that we could not provide users with a hierarchical overview of all the places. To address this, we started thinking about using controlled values from a spatial classification.

## Doing it the right way using controlled values

You do not have to convince librarians that the best way to do spatial subject indexing is by using a classification rather than literal strings. Soon we all agreed to go this way, the main [goals](https://github.com/hbz/nwbib/wiki/Neukonzeption-der-Raumsystematik#ziele) of the approach being:

1. No multiple values referring to the same place, as well as one common entry for a place before and after incorporation into another geographic entity (e.g parts of a town that had once been stand-alone administrative entities)
2. A hierarchical view of all places by NRW's administrative structure: [Regierungsbezirk](https://www.wikidata.org/wiki/Q22721), [Kreise/rural districts](https://www.wikidata.org/wiki/Q20738811), [urban](https://www.wikidata.org/wiki/QQ42744322) and [rural](https://www.wikidata.org/wiki/QQ262166) municipalities as well as [Ortsteil](https://www.wikidata.org/wiki/Q253019)

Here is a mockup of the envisaged classification NWBib editors created in 2017:

<img src="/images/nwbib-wikidata/mockup-classification.png" alt="A mockup of a spatial classification created with Excel" style="width:600px">

### Requirements for reuse of spatial authority data 

We identified the following [requirements](https://github.com/hbz/nwbib/wiki/Neukonzeption-der-Raumsystematik#anforderungen) towards the authority data to be reused for the spatial classification:

- *Coverage*: As many places as possible that were used in spatial tagging must be covered by the authority data. This included some historical places.
- *Hierarchy*: Hierarchical relations between places must be included in the authority data.
- *Extensibility*: NWBib editors must be able to add new places to the classification.

### Why Wikidata rather than GND?

As the discussion happened in the German university library context, NWBib editors naturally tended to use the Integrated Authority File (GND) which is the main authority file in German-speaking countries, being used and maintained by hundreds of institutions and thousands of librarians. As NWBib titles already had been indexed with GND subjects (including spatial subjects) for some years, GND looked like the obvious candidate.

However, GND did not cover most of the requirements: only few hierarchical relations existed in the data. And with the changes during the move to RDA (16.2.2.7), more and more entries had been split into separate entries for an entity before and after its incorporation into a administrative superior entity, see e.g. these two GND entries for Wiesdorf: [4108828-1](https://lobid.org/gnd/4108828-1) & [4099576-8](https://lobid.org/gnd/4099576-8).

The next candidate we looked at was Wikidata as we had already been using it for geodata enrichment. Wikidata already had good coverage of place entries, geo coordinates and hierarchical information. (We didn't really consider GeoNames. It at least has one disadvantage as it doesn't contain historical administrative entities.) As with the GND, Wikidata comes with a technical infrastructure for maintaining the authority data, the difference with Wikidata being that the editing community encompasses virtually anybody and not only catalogers. The implications are twofold:

1. The bigger the community, the easier it is to keep the data up to date which means less work for NWBib editors.
2. With anybody being able to edit the data, NWBib editors justifiably worried about unwanted changes and vandalism.

Furthermore, while the free infrastructure of Wikidata is great to start working on a project, it might lead to problems in the long run if you solely rely on Wikimedia to keep the infrastructure running. We guaranteed NWBib editors that we'd develop a solution that mitigates 2.) as well as the lack of control over the infrastructure by adding some kind of buffer between Wikidata and the NWBib classification so that we could identify and fix unwanted changes before deploying them in NWBib.

## Implementation

After laying out the background, the requirements, the goals and result of the project, the following sections cover the actual implementation. As this project had to be carried out alongside other projects and different maintenance duties by a team of three persons working part-time, the whole duration of the project covered more than two years. This fit quite well with the constant need for review and feedback cycles which sometimes took quite some time due to NWBib editors sitting in two organizations different from the hbz.

### Match strings

As said above, we already had been matching place strings with Wikidata items since 2014 in order to enrich NWBib data with geo coordinates. We had learned early on that using the Wikidata API is not sufficient for matching strings of places with Wikidata items. One reason being that different levels of administrative areas do have very similar names which led to systematic errors. So we created a custom Elasticsearch index from the query which was used in the matching process. As there was no single property for filtering all the places in North Rhine-Westphalia out of Wikidata and as we only wanted to get out those types of items we needed to match the strings with, we had to work with a SPARQL query that would be improved several times. See the evolution of this SPARQL query in [https://git.io/JOVS9](https://git.io/JOVS9) & [https://git.io/JOVS7](https://git.io/JOVS7).

For an optimal matching result, we indexed the German name and alternative names (`label`, `aliases`) as well the geo coordinates (`geo`) for the enrichment. As place strings often contained the name of the superior administrative body for disambiguation, we also added this name to the index (`locatedIn`). Here is a full example of the informationen from Wikidata we loaded into Elasticsearch:

```json
{
   "spatial":{
      "id":"http://www.wikidata.org/entity/Q897382",
      "label":"Ehrenfeld",
      "geo":{
         "lat":50.9464,
         "lon":6.91833
      },
      "type":[
         "http://www.wikidata.org/entity/Q15632166"
      ]
   },
   "aliases":[
      {
         "language":"de",
         "value":"Köln/Ehrenfeld"
      },
      {
         "language":"de",
         "value":"Köln-Ehrenfeld"
      }
   ],
   "locatedIn":{
      "language":"de",
      "value":"Köln-Ehrenfeld"
   }
}
```

It then took quite some manual work in Wikidata (adding items and/or alternative names) as well as adjustment of field boosting (see [https://git.io/J3LFi](https://git.io/J3LFi)) in Elasticsearch to reach a successful matching for around 99% of all NWBib records, which covered approximately 92% of all place strings we had in the data. To get to a 100% coverage, NWBib editors adjusted catalog records and made more than 6000 manual edits to Wikidata adding aliases and type information or creating new entries.

### Update NWBib data

Having reached the milestone of a 100% matching rate for all the place strings, we could move on to the next step: Updating NWBib data with information from Wikidata.

We did this by including the information in a `spatial` JSON object (the JSON key being mapped to the property `http://purl.org/dc/terms/spatial`). In order to not be being susceptible to vandalism or other unwanted Wikidata edits, we refrained from directly using Wikidata URIs. Instead, we added SKOS concept URIs in the `nwbib.de` namespace we could then create a SKOS classification from (see below). The Wikidata entity URIs, the type information and geodata are then embedded in a `focus` (`http://xmlns.com/foaf/0.1/focus`) object. See as example the `spatial` object from the record [HT017710656](https://lobid.org/resources/HT017710656.json):

```json
{
  "spatial":[
     {
        "focus":{
           "id":"http://www.wikidata.org/entity/Q365",
           "geo":{
              "lat":50.942222222222,
              "lon":6.9577777777778
           },
           "type":[
              "http://www.wikidata.org/entity/Q22865",
              "http://www.wikidata.org/entity/Q707813",
              "http://www.wikidata.org/entity/Q200250",
              "http://www.wikidata.org/entity/Q2202509",
              "http://www.wikidata.org/entity/Q42744322",
              "http://www.wikidata.org/entity/Q1549591"
           ]
        },
        "id":"https://nwbib.de/spatial#Q365",
        "type":[
           "Concept"
        ],
        "label":"Köln",
        "notation":"05315000",
        "source":{
           "id":"https://nwbib.de/spatial",
           "label":"Raumsystematik der Nordrhein-Westfälischen Bibliographie"
        }
     }
  ]
}
```

With this setup, it is now possible to query lobid for NWBib resources based on a place's QID, for example:

[`spatial.focus.id:"http://www.wikidata.org/entity/Q365"`](https://lobid.org/resources/search?q=spatial.focus.id%3A%22http%3A%2F%2Fwww.wikidata.org%2Fentity%2FQ365%22)

What's still missing is a hierarchical overview of the places to be browsed by users. To enable this, we created a SKOS (Simple Knowledge Organization System) classification with broader/narrower relations.

### Create & present SKOS classification

As NWBib editors did not want NWBib to directly rely on Wikidata's infrastructure and data, we early on decided to represent the classification in an intermediate SKOS file that we control. The NWBib web application would then rely on this file and not directly on Wikidata. As an additional requirement, it became clear that we would not be able to maintain 100% of the classification in Wikidata. Some parts of the classification were quite NWBib-specific and it wasn't feasible to include them in Wikidata. Also, we could not claim to have authority over the preferred names used in Wikidata so that we had to think about a solution when a label in Wikidata would differ from the label we wanted to used in NWBib.

Here is the setup, we came up with:

1. A SKOS turtle file covering the core spatial NWBib classification with (currently around 40) concepts not covered in Wikidata or where we need to use another label than Wikidata: [nwbib-spatial-conf.ttl](https://github.com/hbz/nwbib/blob/master/conf/nwbib-spatial-conf.ttl)
2. The complete classification as SKOS file created from 1.) and Wikidata: [nwbib-spatial.ttl](https://github.com/hbz/lobid-vocabs/blob/master/nwbib/nwbib-spatial.ttl) which is the same file as you can download at [https://nwbib.de/spatial.ttl](https://nwbib.de/spatial.ttl)).

The HTML classification that is rendered from the SKOS file can be viewed and browsed at [https://nwbib.de/spatial](https://nwbib.de/spatial). Here is a screenshot showing a part of the HTML classification:

![Spatial NWBib classification](/images/nwbib-wikidata/classification-screenshot.png)

You can directly link to each element of the classification using the concept's hash URI which is based on its Wikidata ID – e.g. https://nwbib.de/spatial#Q365. Displayed in parenthesis behind each label is the number of bibliographic resources in NWBib that refer to this place. This number is linked with a result view listing these resources.

### Update Wikidata with links to NWBib

With the concept URIs resolving to the classification entry, the next step could be implemented: adding links from Wikidata to NWBib. Prerequistie is a Wikidata property that enables addition of respective statements to each place in Wikidata. We proposed such a property in the beginning of June 2019, see https://www.wikidata.org/wiki/Wikidata:Property_proposal/NWBib_ID. The Wikidata property [NWBib ID (P6814)](https://www.wikidata.org/wiki/Property:P6814) was created quickly one or two days later.

We then batch loaded the NWBib IDs with QuickStatements, see [https://github.com/hbz/nwbib/issues/469](https://github.com/hbz/nwbib/issues/469). By now, we could get all relevant Wikidata entries by querying for all items that have a P6814 statement.

Until now, we were getting information about hierarchy (superordinated administrative entity) from [P131 (located in the administrative territorial entity)](https://www.wikidata.org/wiki/Property:P131) statements. As for some place multiple superordinated administrative entities were listed, we had problems to identify the one, we would use for creating our classification's hierarchy. That's where the Wikidata property [P4900 (broader concept)](https://www.wikidata.org/wiki/Property:P4900) comes handy. We used this to batch load "broader" links to other Wikidata entries with a qualifier to the P6814 statements, see the [corresponding issue](https://github.com/hbz/nwbib/issues/487) for implementation details. As a result, it looks like this in Wikidata, for example:

![NWBib ID entry in Wikidata example with P4900 qualifier](/images/nwbib-wikidata/P4900-example.png)

### Establish editorial process for updating the classification

As noted, an up-to-date SKOS classification is created from

1. the manually maintained SKOS config file [nwbib-spatial-conf.ttl](https://github.com/hbz/nwbib/blob/master/conf/nwbib-spatial-conf.ttl) which includes a) top-level concepts, b) hierarchical relationships that can't be recorded in Wikidata with `P4900` and c) concepts that for some reason have to be maintained outside Wikidata,
2. all Wikidata items with [P6814 NWBib ID](https://www.wikidata.org/wiki/Property:P6814) statements including — if existent – the qualifier [P4900 (broader concept)](https://www.wikidata.org/wiki/Property:P4900).

Generally, statements from the config file (1.) overwrite those from Wikidata (2.). Technically, it works like this:

1. Get relevant Wikidata data via SPARQL, see the [current query](https://github.com/hbz/nwbib/blob/master/conf/wikidata.sparql)
2. Transform result to SKOS
3. Merge result from 2.) with `nwbib-spatial-conf.ttl`, preferring the config file over the other in case of conflicts.

As a sidenote: In the beginning, we hoped to combine 1.) & 2.) in one step by using a SPARQL `CONSTRUCT` query to directly extract the data from Wikidata in SKOS format, see [https://github.com/hbz/nwbib/wiki/Geo-Index-mit-SPARQL-CONSTRUCT-generieren](https://github.com/hbz/nwbib/wiki/Geo-Index-mit-SPARQL-CONSTRUCT-generieren) (German) & [https://github.com/hbz/lobid-vocabs/issues/85](https://github.com/hbz/lobid-vocabs/issues/85). Unfortunately, Wikidata does not support CONSTRUCT queries for such a large amount of data ([https://phabricator.wikimedia.org/T211178](https://phabricator.wikimedia.org/T211178)).

Aside from the technical update process, we needed to establish an editorial process that includes a review step. After a few iterations, we arrived at this process:

1. NWBib editor wants to changes an entry or decides to inlcude a new place by adding an [NWBib ID (P6814)](https://www.wikidata.org/wiki/Property:P6814) statement.
2. NWBib editor triggers a new build of the classification in the test system by clicking a button "Update from Wikidata" and checks whether the desired change is achieved. (By now, the editor can already use the new entry in cataloging by copying from the test system the field content as described above in the "Cataloging" paragraph).
4. NWBib editor contacts lobid team by email and requests rebuild of classification in production.
5. lobid team updates classificatio in production and notifies about possible undesired changes coming in from Wikidata.


## Further resources

- [Slides from WikidataCon 2019](https://slides.lobid.org/nwbib-wikidatacon/)
- [Thread in SWIB20 Mattermost](https://gist.github.com/acka47/e24a091b27f4095cbafe3cf3803b0b9a)
- [Wiki (German)](https://github.com/hbz/nwbib/wiki)
- [Issues (German)](https://github.com/hbz/nwbib/issues?q=is%3Aissue+project%3Ahbz%2F3)