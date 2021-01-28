---
layout: post
title: "How we built a spatial subject classification based on Wikidata"
author: Adrian Pohl
date: 2021-02-27-04
tags: nwbib
---

The Open Infrastructure team of hbz that provides and maintains lobid is also responsible for the technical infastructure of the North-Rhine Westphalian Bibliography (NWBib), a regional bibliography that records literature about North-Rhine Westphalia, its regions, places and people. As of now, NWBib comrpises more than 440,000 resources –  besides monographs, NWBib especially collects articles as well as maps, DVDs etc.

In 2019 and 2020 we carried out a project to upgrade spatial subject indexing from using strings to using controlled values from a spatial classification that is created from Wikidata. I already shared progress on the project in a talk at WikidataCon 2019 ([slides](https://slides.lobid.org/nwbib-wikidatacon/)) but never got to write down a wrap-up of the whole endeavour. A conversation with Magnus Sälgö, Péter Király and Osma Suominen in the Mattermost chat of [SWIB20](https://swib.org/swib20) ([archived thread](https://gist.github.com/acka47/e24a091b27f4095cbafe3cf3803b0b9a)) reminded me that this topic is of possibly of bigger interest to other library folks and now I finally took the time to write this post.

## NWBib as part of hbz union catalogue

NWBib editors use our Aleph union catalog for cataloguing which means that NWBib records are also part of [lobid-resources](https://lobid.org/resources), aLOD-based web API for the union catalogue. (See [all blog posts about lobid-resources](https://blog.lobid.org/tags/lobid-resources.)) Within lobid-resources, all NWBib titles are marked like this:

```json
{
  "inCollection" : [ {
    "id" : "http://lobid.org/resources/HT014176012#!",
    "type" : [ "Collection" ],
    "label" : "Nordrhein-Westfälische Bibliographie (NWBib)"
  } ]
}
```

This information enables to easily query NWBib data via lobid-resourcs by attaching [`inCollection.id:"http://lobid.org/resources/HT014176012#!"`](https://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22) to a lobid-resources query.

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

Besides the sub-optimal matching there were other drawbacks with this approach. Of course the well-known problem occured which everybody encounters after some time when using typed strings instead of controlled values: you get lots of different strings for the same place because of different recording practices or typos. In the [2017 list containing all the distinct place name strings found in NWBib including an occurence count](https://gist.github.com/acka47/ccd3715201442e8cb78c70cca9ebd1ab) you can find for example five strings referring to Wiesdorf, a part of Leverkusen: 

- "Wiesdorf"
- "Wiesdorf <Niederrhein>"
- "Wiesdorf, Niederrhein"
- "Leverkusen-Wiesdorf"
- "Leverkusen- Wiesdorf (Niederrhein)"

Another drawback was that we could not provide users with a hierarchical classification of all the places.

## Doing it the right way: use of controlled values

### Making the argument for Wikidata

### Match values

### Add links to Wikidata

Propose property: https://github.com/hbz/nwbib/issues/446
Batch load: https://github.com/hbz/nwbib/issues/469

### Create classification from Wikidata

SKOS etc.



https://github.com/hbz/nwbib/wiki/Wikidata-Matchingverfahren

Thread in SWIB20 Mattermost: https://gist.github.com/acka47/e24a091b27f4095cbafe3cf3803b0b9a
Slides from WikidataCon 2019: https://slides.lobid.org/nwbib-wikidatacon/
Wiki (German): https://github.com/hbz/nwbib/wiki
Issues: https://github.com/hbz/nwbib/issues?q=is%3Aissue+project%3Ahbz%2F3+ 