---
layout: post
title: "How we built a spatial subject classification based on Wikidata"
author: Adrian Pohl
tags: nwbib
---

The Open Infrastructure team of hbz that provides and maintains lobid is also responsible for the technical infastructure of the North-Rhine Westphalian Bibliography (NWBib), a regional bibliography that records literature about North-Rhine Westphalia, its regions, places and people. As of now, NWBib comrpises more than 440,000 resources –  besides monographs, NWBib especially collects articles as well as maps, DVDs etc.

In 2019 and 2020 we carried out a project to upgrade spatial subject indexing from using strings to using controlled values from a spatial classification that is created from Wikidata. I already shared progress on the project in a talk at WikidataCon 2019 ([slides](https://slides.lobid.org/nwbib-wikidatacon/)) but never got to write down a wrap-up of the whole endeavour. A conversation with Magnus Sälgö, Péter Király and Osma Suominen in the Mattermost chat of [SWIB20](https://swib.org/swib20) ([archived thread](https://gist.github.com/acka47/e24a091b27f4095cbafe3cf3803b0b9a)) reminded me that this topic is of possibly of bigger interest to other library folks and now I finally took the time to write this post.

## Division of technical and editorial NWBib work

Before diving deeper into the actual project, a short explainer how the technical and editorial work is divided between different people and institutions. NWBib editors are working at the University and State Libraries Düsseldorf and Münster while the whole udnerlying technical infastrcuture (from cataloging to the web presence of NWBib) is managed by hbz which mostly means: the Open Infrastructure team which is running this blog.

## NWBib as part of hbz union catalogue

NWBib editors use our Aleph union catalog for cataloguing which means that NWBib records are also part of [lobid-resources](https://lobid.org/resources), a LOD-based web API for the union catalogue. (See [all blog posts about lobid-resources](https://blog.lobid.org/tags/lobid-resources.)) Within lobid-resources, all NWBib titles are marked like this:

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

Basically, this is what we are utilizing to offer the web interface for NWBib at https://nwbib.de.

## Spatial subject indexing in NWBib

For years, subject indexing in NWBib has been don mainly by adding to a record the text strings of places the recources is about. It looked like this in the source data (see this [ZDB example](https://github.com/hbz/nwbib/wiki/Aktualisierung-der-NWBib-Systematik-Daten-in-der-ZDB#beispiel) to see how it looks in MARC21):

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

The strings "Duisburg" and "Essen" refer to the cities in NRW with this name. Around three quarters of NWBib records (~300k records) contained one or more of these place name strings. In 2017, we had 8,800 distinct strings for places  which referred mostly to administrative areas but also to monasteries, principalities, natural regions etc.

## 1st phase: Enriching strings with geo coordinates

For years (2014-2019), we've been using Wikidata to enrich NWBib with geo coordinates by matching those place strings to Wikidata items and pulling the geo coordinates from there. We chose a rather naive matching approach which resulted in poor or no matches for some resources. However, it was good enough to enable map-based filtering of results at nwbib.de.

Besides the sub-optimal matching there were other drawbacks with this approach. Of course the well-known problem occured which everybody encounters after some time when using typed strings instead of controlled values: you get lots of different strings for the same place because of different recording practices or typos. IN 2017, NWBib included around 8,800 distinct spatial strings  which roughly referred to 4,500 different places. Taking a look at a [2017 list containing all the distinct place name strings found in NWBib including an occurence count](https://gist.github.com/acka47/ccd3715201442e8cb78c70cca9ebd1ab) you for example find five strings referring to Wiesdorf, a part of Leverkusen:

- "Wiesdorf"
- "Wiesdorf &lt;Niederrhein&gt;"
- "Wiesdorf, Niederrhein"
- "Leverkusen-Wiesdorf"
- "Leverkusen- Wiesdorf (Niederrhein)"

Another drawback was that we could not provide users with a hierarchical overview of all the places. To address this, we started thinking about using controlled values from a spatial classification.

## Doing it the right way: use of controlled values

You do not have to convince librarians that the best way to do spatial subject indexing is by using a classification rather than literal strings. Soon we all agreed to go this way, the main [**goals**](https://github.com/hbz/nwbib/wiki/Neukonzeption-der-Raumsystematik#ziele) of the approach being:

1. no multiple values referring to the same place as well as one entry for a place before and after incorporation into another geographic entity (.e.g parts of a town that had once been stand-alone administrative entities)
2. a hierarchical view of all places by NRW's administrative structure: [Regierungsbezirk](https://www.wikidata.org/wiki/Q22721), [Kreise/rural districts](https://www.wikidata.org/wiki/Q20738811), [urban](https://www.wikidata.org/wiki/QQ42744322) and [rural](https://www.wikidata.org/wiki/QQ262166) municipalities as well as [Ortsteil](https://www.wikidata.org/wiki/Q253019)

Here is a mockup of the envisaged classification NWBib editors created in 2017:

<img src="/images/nwbib-wikidata/mockup-classification.png" alt="A mockup of a spatial classification created with Excel" style="width:600px">

### Requirements

We identified the following [requirements](https://github.com/hbz/nwbib/wiki/Neukonzeption-der-Raumsystematik#anforderungen) towards the autority data to be reused for the spatial classification:

- *Coverage*: As many places as possible that are currently used in spatial tagging should be covered by the authority data.
- *Hierarchy*: Hierarchical relations between places must be included in the authority data.
- *Extensibility*: NWBib editors must be able to add new places to the classification.

### Why Wikidata rather than GND?

As the discussion happened in German university library context, NWBib editors naturally tended to use the Integrated Authority File (GND) which is the main authority file in the German-speaking world being used and maintained by hundreds of institutions and thousands of librarians. As NWBib titles had been indexed with GND subjects (including spatial subjects) for some years, GND looked like the obvious candidate.****

However, GND did not cover most of the requirements: only few hierarchical relations existed in the data. And with the changes during the move to RDA RDA (16.2.2.7), single entries had been split into separate entries for entities before and another after their incorporation into a administrative superior entity, see e.g. these two GND entries for Wiesdorf: [4108828-1](https://lobid.org/gnd/4108828-1) & [4099576-8](https://lobid.org/gnd/4099576-8)

The next candidate we looked at was Wikidata as we were already using it for geodata enrichment. Wikidata already had good coverage of place entries, geo coordinates and hierarchical information. (We didn't really consider GeoNames. It at least has one disadvantage as it doesn't contain historical administrative entities.) As iwth the GND, Wikidata comes with a technical infrastructure for maintaining the authority data. The difference with Wikidata being that the editing community encompasses virtually anybody and not only cataloguers. This fact has two sides:

1. The bigger the community the easier it is to keep the data up to date which means less work for NWBib editors.
2. With anybody being able to edit the data, NWBib editors justifiably worried about unwanted changes and vandalism.

Furthermore, while the free infrastructure of Wikidata is great to start working on a project, it might lead to problems in the long run if you solely rely on Wikimedia to keep the infrastructure running. We guaranteed NWBib editors that we'd develop a solution that mitigates 2.) as well as the lack of control over the infrastructure e.g by adding some kind of buffer between Wikidata and NWBib classification so that we could identify and fix unwanted changes before deploying them in NWBib. How we deal with this will be addressed in the next section on implementation.

## Implementation

After laying out the background, requirements and goals we wanted to reach in the project, let us now move on to take a look at the implementation.

### Match strings

Matching via API isn't sufficient (e.g. because different levels of administrative areas have very similar names)

Matching via custom Elasticsearch index (maximizing precision by type restriction)

The index is built based on Wikidata SPARQL query for specific entities in NRW: https://github.com/hbz/lobid-resources/commits/73a19ba820c82cb04a866121810fc919c5f0d370/src/main/resources/getNwbibSubjectLocationsAsWikidataEntities.txt & https://github.com/hbz/lobid-resources/commits/master/src/main/resources/getNwbibSubjectLocationsAsWikidataEntities.sparql

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

Successful automatic matching for >99% of records and ~92% of the place strings

For <1000 strings the matching was incorrect

Catalogers adjusted catalog records and made >6000 manual edits to Wikidata to reach 100% coverage (adding aliases & type information, creating new entries)

### Add links to Wikidata

Propose property: https://github.com/hbz/nwbib/issues/446
Batch load: https://github.com/hbz/nwbib/issues/469

### Create classification from Wikidata

SKOS etc.

### Update lobid

Based on Wikidata entries and hierarchical statements (mainly P131)

Add SKOS concept URIs and links to Wikidata to lobid/NWBib, see "spatial" object in [JSON example](https://lobid.org/resources/HT017710656.json):

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

Voilá, now you are able to query for NWBib resources based on a place's QID:

[`spatial.focus.id:"http://www.wikidata.org/entity/Q365" AND inCollection.id:"http://lobid.org/resources/HT014176012#!"`](https://lobid.org/resources/search?q=spatial.focus.id%3A%22http%3A%2F%2Fwww.wikidata.org%2Fentity%2FQ365%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22)

### Update Wikidata with links to NWBib

Create Wikidata property for NWBib ID: https://www.wikidata.org/wiki/Property:P6814
Batch load NWBib IDs with QuickStatements: https://github.com/hbz/nwbib/issues/469
Add broader information to NWBib ID statements with qualifier P4900: https://github.com/hbz/nwbib/issues/487

https://slides.lobid.org/nwbib-wikidatacon/img/wd-example.png

### Update catalog & use new IDs in cataloging

In the end of 2019 catalogers started to use Wikidata-based URIs for spatial subject indexing in Aleph:

```xml
<datafield tag="700" ind1="n" ind2="1">
  <subfield code="a">Köln</subfield>
  <subfield code="0">https://nwbib.de/spatial#Q365</subfield>
</datafield>
```

For the cataloguers, we have added hidden copy buttons behind every classification entry that to get the needed Aleph format with one click. Just hover over the space behind each classification entry to make the button visible: 

Clicking on it copies the following content in your clipboard: `Köln$$0https://nwbib.de/spatial#Q365`

### Proxy against vandalism and unwanted edits

As NWBib editors did not want NWBib to directly rely on Wikidata's infrastructure and data we had to create an intermediate representation of the classification that is under our control. We decided to store the classification the we built from Wikidata in an intermediate SKOS (Simple Knowledge Organization System) file the NWBib web application would rely on.


1. Core classification with concepts not covered in Wikidata or where we need to use another label than Wikidata: https://github.com/hbz/nwbib/blob/master/conf/nwbib-spatial-conf.ttl
2. Complete classification created from 1.) and Wikidata: https://github.com/hbz/lobid-vocabs/blob/master/nwbib/nwbib-spatial.ttl (same as at https://nwbib.de/spatial.ttl)

Updating the classification
1. SPARQL Wikidata: https://github.com/hbz/nwbib/blob/master/conf/wikidata.sparql
2. Transform to SKOS (unfortunately, CONSTRUCT queries don't work): https://github.com/hbz/nwbib/blob/5f2b06cdb416430e58a7a4ddc874efec398e44ea/app/SpatialToSkos.java
3. Merge with spatial-conf

In the beginning, we hoped to achieve 1.) & 2.) in one step by using a SPARQL `CONSTRUCT` query to directly extract the data from Wikidata in SKOS format, see https://github.com/hbz/nwbib/wiki/Geo-Index-mit-SPARQL-CONSTRUCT-generieren (German) & https://github.com/hbz/lobid-vocabs/issues/85. Unfortunately, Wikidata does not support CONSTRUCT queries for such a large amount of data (https://phabricator.wikimedia.org/T211178).

### Find out best process for updating classification including review

https://github.com/hbz/nwbib/wiki/Aktualisierungsprozess-f%C3%BCr-die-NWBib-Raumsystematik

## Challenges & Lessons Learned

- take your time
- 


https://github.com/hbz/nwbib/wiki/Wikidata-Matchingverfahren
Thread in SWIB20 Mattermost: https://gist.github.com/acka47/e24a091b27f4095cbafe3cf3803b0b9a
Slides from WikidataCon 2019: https://slides.lobid.org/nwbib-wikidatacon/
Wiki (German): https://github.com/hbz/nwbib/wiki
Issues: https://github.com/hbz/nwbib/issues?q=is%3Aissue+project%3Ahbz%2F3+ 