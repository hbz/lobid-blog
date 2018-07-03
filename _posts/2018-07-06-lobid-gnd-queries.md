---
layout: post
title: "Die GND mit lobid abfragen"
date: 2018-07-06
author: Adrian Pohl
---

Im [vorherigen Beitrag]() haben wir bereits die Oberfläche von [lobid-gnd](https://lobid.org/gnd) und ihre Funktionen beschrieben. Die API ermöglicht aber auch komplexere Abfragen, für die man sich ein wenig mit den dahinterliegenden Daten vertraut machen muss. Dies soll an einigen Beispielen ausgeführt werden. 

# Wie lass ich mir die JSON-Daten anzeigen?

Im folgenden wird immer wieder auf die strukturierten Daten im Format JSON-LD bezug genommen, die es für jeden Eintrag in lobid-gnd gibt. Anzeigen lassen diese sich wie folgt:

1. Mit Klick auf das JSON-LD-Zeichen in einer Detailansicht:
[![Screenshot](/images/focus-json-ld.png "Hinweis auf Link zum JSON-LD")](http://lobid.org/gnd/11850391X)
2. Durch Anhängen von `.json` an die URL eines Einzeltreffers, z.B. [http://lobid.org/gnd/11850391X.json](http://lobid.org/gnd/11850391X)
3. **Bei Suchanfragen** muss der Parameter `format=json` angehängt werden, um die gesamte Ergebnisliste als JSON-LD anzuzeigen. (Alternativ können auch das JSON eines Treffers per Zeile mit JSON Lines ausgegeben werden (Parameter `format=jsonl`).

# Query basics

## Lucene Query Language


## Suche vs. Filter


## _exists_-Abfragen


# Beispiele

## Einträge mit Wikidata-Link aber ohne Bild

Im Kontext der Anzeige eines zufälligen Bildes auf der [lobid-gnd-Startseite](https://lobid.org/gnd), wollte ich wissen, wie viele und welche Einträge denn einen Wikidata-Link aber kein Bild haben. Dafür schaue ich mir zunächst am besten die Daten eines Eintrags an der beides hat, z.B. [Hannah Arendt](http://lobid.org/gnd/11850391X.json). Hier die für uns wichtigen Ausschnitte:

```json
{
  "id":"http://d-nb.info/gnd/11850391X",
  "depiction":[
    {
      "id":"https://commons.wikimedia.org/wiki/Special:FilePath/Hannah_arendt-150x150.jpg",
      "url":"https://commons.wikimedia.org/wiki/File:Hannah_arendt-150x150.jpg?uselang=de",
      "thumbnail":"https://commons.wikimedia.org/wiki/Special:FilePath/Hannah_arendt-150x150.jpg?width=270"
    }
  ],
  "sameAs":[
    {
      "collection":{
        "abbr":"WIKIDATA",
        "name":"Wikidata",
        "publisher":"Wikimedia Foundation Inc.",
        "icon":"https://www.wikidata.org/static/favicon/wikidata.ico",
        "id":"http://www.wikidata.org/entity/Q2013"
      },
      "id":"http://www.wikidata.org/entity/Q60025"
    }
  ]
}
```

Die Verlinkung zu Wikidata findet sich innerhalb eines Objekts im `sameAs`-Array. Gekennzeichnet als Wikidata-Verlinkung ist sie durch die verknüpfte Sammlung (`collection`), u.a. durch die ID `http://www.wikidata.org/entity/Q2013` für Wikidata. Will ich also meine Suche auf Einträge einschränken, die einen Link zu Wikidata haben muss ich einen Filter auf das Feld `sameAs.collection.id` (diese Notation ist die gängige, um ein JSON-Feld innerhalb einer hierarchisch geschachtelten Struktur zu identifizieren) setzen:

[http://lobid.org/gnd/search?filter=sameAs.collection.id:"http://www.wikidata.org/entity/Q2013"](http://lobid.org/gnd/search?filter=sameAs.collection.id:%22http://www.wikidata.org/entity/Q2013%22)

**Hinweis**: Damit der Filter funktioniert und es keine Probleme mit der URL gibt, muss die Wikidata-URI (`http://www.wikidata.org/entity/Q2013`) in Anführungszeichen gesetzt werden.

Wir wollen aber nicht alle Einträge mit Wikidata-Link, sondern nur jene *ohne Bild*. Das heißt wird müssen die Bedingung ergänzen, dass das Feld `depiction` nicht vorhanden ist. Hier kommt uns die `_exist_`-Query von Elasticsearch zur Hilfe. Ich kann mir damit alle Einträge anzeigen, die ein bestimmes Feld aufweisen, ganz gleichen mit welchem Wert und kombiniert mit dem Booleschen "NOT" kann ich eben auch alle Einträge anzeigen, bei denen ein bestimmtes Feld *nicht* vorhanden ist. Konkret müssen wir zur Suchanfrage `+AND+NOT+_exists_:depiction` ergänzen, so dass am Ende bei rauskommt:

[http://lobid.org/gnd/search?filter=sameAs.collection.id:"http://www.wikidata.org/entity/Q2013"+AND+NOT+_exists_:depiction](http://lobid.org/gnd/search?filter=sameAs.collection.id:"http://www.wikidata.org/entity/Q2013"+AND+NOT+_exists_:depiction)
