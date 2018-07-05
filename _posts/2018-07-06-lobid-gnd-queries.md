---
layout: post
title: "Die GND mit lobid abfragen"
date: 2018-07-06
author: Adrian Pohl
---

Im [vorherigen Beitrag](http://blog.lobid.org/2018/07/03/lobid-gnd-suche.html) haben wir bereits die Oberfläche von [lobid-gnd](https://lobid.org/gnd) und ihre Funktionen beschrieben. Die API ermöglicht aber auch komplexere Abfragen, für die man sich ein wenig mit den zugrundeliegenden Datenstrukturen vertraut machen muss. Dies soll in diesem Beitrag an einigen Beispielen ausgeführt werden.

# Query basics

 Bevor wir die Suchmöglichkeiten an einigen Beispielen illustrieren, werden zunächst einige generelle Informationen zur Suche geliefert.

## Eingabe

Alle Abfragen können über das Suchfeld auf der lobid-gnd-Seite eingegeben werden:

![Screenshot](/images/2018-07-06-lobid-gnd-queries/enter-complex-query.png "Komplexe Query in Eingabefenster")

Selbstverständlich können die Queries auch per URL kodiert an die API gesendet werden, z.B. via curl:

![Screenshot](/images/2018-07-06-lobid-gnd-queries/curl-query.png "Query via curl")

## Default-Sucheinstellungen

Standardmäßig geht eine im Suchfenster angestoßene Suche über alle Felder. Mehrere Suchterme werden dabei per default mit einem Booleschen OR verknüpft.

## Query Language

lobid-gnd wird auf Basis von [Elasticsearch](https://de.wikipedia.org/wiki/Elasticsearch) angeboten. Dadurch wird die  unterstützt. Die Query Language soll hier nicht noch einmal dokumentiert werden, wir verweisen stattdessen auf die Dokumentation der  [Elasticsearch Query String Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax) sowie der [Apache Lucene Query Syntax](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html). (Elasticsearch basiert auf [Apache Lucene](https://de.wikipedia.org/wiki/Apache_Lucene).)

## `_exists_`-Abfragen

Häufig ist es hilfreich herauszufinden, wieviele und welche Einträge überhaupt eine bestimmte Information angeben bzw. in wievielen Einträgen ein bestimmte Feld fehlt. Für solcherlei Anfragen eignet sich die `_exists_`-Anfrage, die im Query-Kontext in der Form `_exists_:{Feldname}` mitgegeben werden kann, optional mit dem Booleschen `NOT`, um alle Einträge zu bekommen, die das jeweilige *nicht* haben.

# Anzeige der JSON-Daten

Im folgenden wird immer wieder auf die strukturierten Daten im Format JSON-LD Bezug genommen, die es für jeden Eintrag in lobid-gnd gibt. Anzeigen lassen sich diese wie folgt:

1. Mit Klick auf das JSON-LD-Zeichen in einer Detailansicht:
[![Screenshot](/images/2018-07-06-lobid-gnd-queries/focus-json-ld.png "Hinweis auf Link zum JSON-LD")](http://lobid.org/gnd/11850391X)
2. Durch Anhängen von `.json` an die URL eines Einzeltreffers, z.B. [http://lobid.org/gnd/11850391X.json](http://lobid.org/gnd/11850391X)
3. Der Vollständigkeit halber: **Bei Suchanfragen** muss der Parameter `format=json` angehängt werden, um die gesamte Ergebnisliste als JSON-LD anzuzeigen, z.B. [http://lobid.org/gnd/search?q=hannah+arendt&format=json](http://lobid.org/gnd/search?q=hannah+arendt&format=json). (Alternativ können auch mit dem Parameter `format=jsonl` JSON Lines ausgegeben werden, d.h. pro Zeile ein Eintrag als JSON, z.B. [http://lobid.org/gnd/search?q=hannah+arendt&format=jsonl](http://lobid.org/gnd/search?q=hannah+arendt&format=jsonl).

# Beispiele

## Boolesche Operatoren

Als Defaultsuche ist in lobid-gnd eine OR-Verknüpfung mehrerer Suchterme eingestellt. Boolesche Operatoren lassen sich aber auch passgenau anwenden.

Beispiele:
- Suche nach "Dom" UND "Aachen OR Köln": [`Dom AND (Aachen OR Köln)`](http://lobid.org/gnd/search?q=Dom+AND+(Aachen OR Köln))
- [Geographika in Äthiopien oder Eritrea](http://lobid.org/gnd/search?q=type%3APlaceOrGeographicName+AND+geographicAreaCode.id%3A%28%22http%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fgeographic-area-code%23XC-ET%22+OR+%22http%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fgeographic-area-code%23XC-ER%22%29)

## Einträge mit Angabe eines Architekten

Beim Betrachten etwa des Eintrags zum [Friedenspark Köln](http://lobid.org/gnd/1065252633) fällt auf, dass ein Architekt angegeben ist. Bei Interesse daran, welche Einträge noch Architekt*innen angeben, lässt sich das wie folgt herausfinden.

Ich schaue im JSON nach, wie das entsprechende Feld heißt:
```json
{
  "id":"http://d-nb.info/gnd/1065252633",
  "architect":[
    {
      "id":"http://d-nb.info/gnd/118530232",
      "label":"Encke, Fritz"
    }
  ]
}
```

Dann schreibe ich die entsprechende `_exists`-[Anfrage](http://lobid.org/gnd/search?q=_exists_:architect):
![Screenshot](/images/2018-07-06-lobid-gnd-queries/architect-query.png "architect-Sucheingabe")

## Gleichzeitige Suche in Ansetzungs- und Verweisungsformen

Aus einer E-Mail-Anfrage an das lobid-Team:

> Noch eine Frage habe ich zur API. Kann ich die Suche nach Namen so einschränken, dass ich nach exakten Matches in den variantName oder preferredName suchen kann?

Die [Lucene Query Parser Syntax](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html). unterstützt zwei Varianten, das umzusetzen: mit dem `AND`-Operator oder dem `+`-Zeichen:

- [`preferredName:(Muka AND Arnošt) OR variantName:(Muka AND Arnošt)`](http://lobid.org/gnd/search?q=preferredName:(Muka AND Arnošt) OR variantName:(Muka AND Arnošt))
- [`preferredName:(+Muka +Arnošt) OR variantName:(+Muka +Arnošt)`](http://lobid.org/gnd/search?q=preferredName:(+Muka +Arnošt) OR variantName:(+Muka +Arnošt))


## Suche nach Einträgen mit Wikidata-Link aber ohne Bild

Im Kontext der Anzeige eines zufälligen Bildes auf der [lobid-gnd-Startseite](https://lobid.org/gnd), war es nützlich zu wissen, wie viele und welche Einträge denn einen Wikidata-Link aber kein Bild haben. Dafür schaue ich mir zunächst am besten die Daten eines Eintrags an der beides hat, z.B. [Hannah Arendt](http://lobid.org/gnd/11850391X.json). Hier die für uns wichtigen Ausschnitte:

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

Die Verlinkung zu Wikidata findet sich innerhalb eines Objekts im `sameAs`-Array. Gekennzeichnet als Wikidata-Verlinkung ist sie durch die angegebene Sammlung (`collection`). Will ich also meine Suche auf Einträge einschränken, die einen Link zu Wikidata haben muss ich nach Einträgen mit der ID `http://www.wikidata.org/entity/Q2013` im Feld `sameAs.collection.id` (diese Notation ist die gängige, um ein JSON-Feld innerhalb einer hierarchisch geschachtelten Struktur zu identifizieren) suchen:

[`sameAs.collection.id:"http://www.wikidata.org/entity/Q2013"`](http://lobid.org/gnd/search?q=sameAs.collection.id:%22http://www.wikidata.org/entity/Q2013%22)

**Hinweis**: Damit die Suche funktioniert und es keine Probleme mit der URL gibt, muss die Wikidata-URI (`http://www.wikidata.org/entity/Q2013`) in Anführungszeichen gesetzt werden.

Wir wollen aber nicht alle Einträge mit Wikidata-Link, sondern nur jene *ohne Bild*. Das heißt wird müssen die Bedingung ergänzen, dass das Feld `depiction` nicht vorhanden ist. Hier kommt uns die `_exist_`-Query zur Hilfe. Ich kann mir damit alle Einträge anzeigen, die ein bestimtmes Feld aufweisen, ganz gleichen mit welchem Inhalt und kombiniert mit dem Booleschen "NOT" kann ich eben auch alle Einträge anzeigen, bei denen ein bestimmtes Feld *nicht* vorhanden ist. Konkret müssen wir zur Suchanfrage `+AND+NOT+_exists_:depiction` ergänzen, so dass am Ende bei rauskommt:

[`sameAs.collection.id:"http://www.wikidata.org/entity/Q2013" AND NOT _exists_:depiction`](http://lobid.org/gnd/search?q=sameAs.collection.id:"http://www.wikidata.org/entity/Q2013"+AND+NOT+_exists_:depiction)

## Personen, die während der NS-Zeit in Köln geboren wurden

Wenn ich eine Frage beantworten möchte, wie "Welche Personen in der GND wurden in der NS-Zeit in Köln geboren?", dann ist es sinnvoll, sich einen Eintrag zu suchen, der die nötigen Informationen zur Beantwortung einer solchen Frage besitzt. Hier z.B. der Eintrag zu [Konrad Adenauer](http://lobid.org/gnd/11850066X.json), der Informationen zu Geburtsort und -datum hat:

```json
{
  "id":"http://d-nb.info/gnd/11850066X",
  "placeOfBirth":[
    {
      "id":"http://d-nb.info/gnd/4031483-2",
      "label":"Köln"
    }
  ],
  "dateOfBirth":[
    "1876-01-05"
  ]
}
```

Den ersten Schritt – die Eingrenzung auf in Köln geborene Personen – können wir auf einfache Weise über die Benutzeroberfläche vollziehen: Mt einem Klick auf die Lupe neben "Geburtsort Köln" wird eine Abfrage nach allen in Köln geborenen Menschen in der GND gestartet.

 ![Screenshot](/images/2018-07-06-lobid-gnd-queries/lupe-klick.png "Suche per Lupe")

 Jetzt müssen wir die vorhandene Abfrage ([]`placeOfBirth.id:"http://d-nb.info/gnd/4031483-2"`](http://lobid.org/gnd/search?q=placeOfBirth.id%3A%22http%3A%2F%2Fd-nb.info%2Fgnd%2F4031483-2%22&format=html)) noch um eine Einschränkung des Geburtsdatums ergänzen. Auch hier unterstützt uns Elasticsearch mit der [range query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#_ranges), die Zeitrahmen mit verschiedenen Detailgraden (Jahr, Monat, Tag etc.) ermöglicht. Für unseren Fall probieren wir zunächst die tagesgenaue Eingrenzung mit `dateOfBirth:[1933-01-30 TO 1945-05-08]`:

 [`placeOfBirth.id:"http://d-nb.info/gnd/4031483-2" AND dateOfBirth:[1933-01-30 TO 1945-05-08]`](http://lobid.org/gnd/search?q=placeOfBirth.id%3A%22http%3A%2F%2Fd-nb.info%2Fgnd%2F4031483-2%22+AND+dateOfBirth%3A%5B1933-01-30+TO+1945-05-08%5D)

 Da bei vielen Personen nur das Geburtsjahr angegeben ist, ist ein Test der jahresgenauen Abfrage sinnvoll:

 [`placeOfBirth.id:"http://d-nb.info/gnd/4031483-2" AND dateOfBirth:[1933 TO 1945]`](http://lobid.org/gnd/search?q=placeOfBirth.id%3A%22http%3A%2F%2Fd-nb.info%2Fgnd%2F4031483-2%22+AND+dateOfBirth%3A%5B1933+TO+1945%5D)

 Diese Abfrage beinhaltet nun auch alle Treffer, bei denen nur das Geburtsjahr "1933" oder "1945" angegeben ist aber natürlich auch tagesgenaue Geburtstage vor dem 30. Januar 1933 oder nach dem 8.5.1945. Je nach Zweck kann die eine oder andere Abfrage sinnvoller sein.
