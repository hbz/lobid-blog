---
layout: post
title: "NWBib-Daten für Coding da Vinci"
date: 2019-10-08
author: Adrian Pohl, Fabian Steeg, Pascal Christoph
tags: nwbib
---

Der Hackathon "[Coding da Vinci (CdV)](https://codingdavinci.de/)" wird seit 2014 jährlich in Deutschland ausgerichtet. Ziel von CdV ist es, Entwickler\*innen zu motivieren, Anwendungen zu erarbeiten, in denen offene Daten aus Kultureinrichtungen nutzbar gemacht werden. Wir haben über die Jahre die verschiedenen [CdV Hackathons](https://codingdavinci.de/dokumentation/) beobachtet und immer wieder überlegt, Daten beizutragen. Jetzt ist es endlich so weit: Zum Hackathon ["Coding da Vinci Westfalen-Ruhrgebiet"](https://codingdavinci.de/events/westfalen-ruhrgebiet/) bieten wir die [Nordrhein-Westfälische Bibliographie (NWBib)](https://nwbib.de) als [Datenset](https://codingdavinci.de/daten/#hochschulbibliothekszentrum-des-landes-nordrhein-westfalen) an, das die Teilnehmer\*innen für ihe Anwendungen verwenden können. Die Möglichkeiten zur Nutzung der NWBib-Daten sind leider bisher nicht optimal dokumentiert. Dieser Beitrag soll die Situation verbessern.

# Die NWBib

Die NWBib ist eine Landesbibliographie.

> "Als Regionalbibliografie oder Landesbibliografie versteht man die systematische bibliografische Erfassung der Publikationen (vorrangig Bücher und Aufsätze) über eine Region. Der Begriff Landesbibliographie bezieht sich meist auf ein deutsches Bundesland, während Regionalbibliographien für Teile eines Bundeslandes oder sogar grenzübergreifend (beispielsweise die Bodenseebibliographie) erstellt werden."

<small>Quelle: [https://de.wikipedia.org/wiki/Regionalbibliografie](https://de.wikipedia.org/wiki/Regionalbibliografie)</small>

Da die NWBib die Landesbibliographie für Nordrhein-Westfalen ist, verzeichnet sie Literatur über das Land Nordrhein-Westfalen, seine Regionen, Orte und Persönlichkeiten. Neben Büchern werden vor allem Aufsätze erfasst sowie Landkarten, DVDs und viele andere Medientypen. Sie existiert seit 1983 und weist Literatur seit eben diesem Erscheinungsjahr nach. Das heißt, Publikationen, die vor 1983 erschienen sind, lassen sich dort nicht finden. Derzeit umfasst die Bibliographie etwa 420.000 Einträge.

**Nur Metadaten, keine Objekte**

Eine Bibliographie ist ein Nachweisinstrument. Das heißt, sie sammelt lediglich die Beschreibungen von Publikationen und keine Volltexte.

# Die NWBib als Teil des hbz-Verbundkatalogs

Die Redaktion der NWBib in den Universitäts- und Landesbibliotheken Düsseldorf und Münster (mit Unterstützung der Universitäts- und Landesbibliothek Bonn) nutzt gängige bibliothekarische Erschließungsstandards (Resource Description and Access, RDA) zur Erfassung der Titel. Die Daten werden als Teil des [hbz-Verbundkatalogs](https://de.wikipedia.org/wiki/Hbz-Verbunddatenbank) gepflegt. Mit [lobid-resources](https://lobid.org/resources) stellt das Hochschulbibliothekszentrum des Landes-Nordrhein-Westfalen (hbz) den Verbundkatalog unter einer CC0-Lizenz als Linked Open Data u.a. über eine Web-API bereit. Im folgenden zeigen wir, welche Informationen in der NWBib verzeichnet sind und wie die Daten über die lobid-resources-API abgefragt werden können.

# Abfragen der NWBib-Daten: die Weboberfläche

Vor dem direkten Einstieg in die JSON-Daten, ist es sinnvoll, sich zunächst ein bisschen mit der NWBib über die Weboberfläche vertraut zu machen. Diese gibt einen guten ersten Einblick in die zugrundeliegenden Metadaten und was damit alles möglich ist.

Die Startseite des Webauftritts unter [nwbib.de](https://nwbib.de) bietet ein Suchfeld für den einfachen Einstieg, eine Beschreibung der NWBib sowie eine Karte für die direkte Eingrenzung der NWBib-Titel nach Ortsbezug, bei der zwischen Kreis- oder Gemeindeebene gewählt werden kann:

<a href="https://nwbib.de">![Startseite](/images/nwbib-at-cdv/nwbib-startseite.png "Startseite")</a>

Ein Klick auf die Stadt "Essen" in der Karte gibt zum Beispiel alle NWBib-Titel zurück, die über Orte, Personen, Veranstaltungen etc. innerhalb der Grenzen Essens handeln. Eine [Suche nach "Essen"](https://nwbib.de/search?q=essen) ist da unspezifischer und gibt beispielsweise auch – aufgrund von [Stemming](https://de.wikipedia.org/wiki/Stemming) im zugrundeliegenden Suchmaschinenindex – Artikel von "Wolfgang Esser" zurück.

<a href="https://nwbib.de/search?q=essen">![Einfache Suche](/images/nwbib-at-cdv/suche.png "Einfache Suche in der NWBib nach 'Essen'")</a>

Ein Suchergebnis lässt sich auf der rechten Seite über verschiedene Filter eingrenzen: nach Erscheinungsjahr, nach Raumbezug über eine Karte oder über Ortsnamen aus der [NWBib-Raumsystematik](https://nwbib.de/spatial), nach Sachgebieten aus der [NWBib-Sachsystematik](https://nwbib.de/subjects) , nach Schlagwörtern der [Gemeinsamen Normdatei](http://lobid.org/gnd), nach Medien- und Publikationstypen sowie nach Bestand in bestimmten Bibliotheken.

Bei einem Einzeltreffer werden die wichtigsten Metadaten angezeigt. Auf einer Karte wird angezeigt, welche Bibliotheken die Ressource in ihrem Bestand haben.

<a href="https://nwbib.de/BT000063880">![Einzeiltreffer](/images/nwbib-at-cdv/einzeltreffer.png "Einzeltrefferanzeige in der NWBib")</a>

Wir laden dazu ein, einfach mal mit der Oberfläche herumzuspielen und die NWBib-Titel ein wenig zu erkunden.

# Abfragen der NWBib über die lobid-API

Jeder NWBib-Titel verlinkt auf seine lobid-Entsprechung mit einem kleinen "Link"-Symbol in der oberen rechten Ecke der Beschreibung:

![lobid-Link](/images/nwbib-at-cdv/lobid-link.png "Einzeltrefferanzeige in der NWBib mit Hervorherbung des Links zu lobid")

In lobid wiederum kann sich – durch Ergänzen von `.json` oder Klick auf das JSON-LD-Icon – das zugrundeliegende JSON (hier [https://lobid.org/resources/BT000063880.json](https://lobid.org/resources/BT000063880.json)) angeschaut werden. Dieses JSON kann über die API abgefragt werden.

![lobid-Einzeltreffer](/images/nwbib-at-cdv/lobid-einzeltreffer.png "Einzeltrefferanzeige inlobid-resources mit Hervorherbung des Links zum JSON")

Im Folgenden werden die grundlegenden Möglichkeiten zur Abfrage der NWBib-Daten gezeigt.

## Eingrenzen auf NWBib

Die lobid-resources-API ist hier dokumentiert: [https://lobid.org/resources/api](https://lobid.org/resources/api). Wir wollen aber nicht in den mehr als 20 Millionen Verbunddaten suchen, sondern lediglich auf die NWBib-Daten zugreifen. Wie funktioniert das?

Jeder NWBib-Titel hat folgende Informationen im JSON, siehe etwa das [Beispiel](https://lobid.org/resources/BT000063880.json):

```json
{
    "inCollection":[
        {
            "id":"http://lobid.org/resources/HT014176012#!",
            "type":[
                "Collection"
            ],
            "label":"Nordrhein-Westfälische Bibliographie (NWBib)"
        }
    ]
}
```

Wir können fast jedes Feld abfragen. Ist das Feld tiefer geschachtelt, geben wir den Pfad per Punktnotation an, im Beispiel `inCollection.id`. Für die Eingrenzung einer Suche auf NWBib-Titel müssen wir also folgendes ergänzen: [`inCollection.id:"http://lobid.org/resources/HT014176012#!"`](http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22)

## Inhaltstypen, Paging, Bulk Download

Die oben genannte Abfrage gibt über den Browser eine HTML-Sicht zurück. Ohne `Accept` Header wird über cURL o.ä. automatisch JSON(-LD) geliefert. Durch Ergänzung von `format=json` (bei Einzeltrefferen wie bereits erwähnt auch `.json`) lässt sich die Rückgabe von JSON auch im Browser erzwingen, z.B. [`inCollection.id:"http://lobid.org/resources/HT014176012#!"&format=json`](http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22&format=json)

Ergebnislisten werden per default auf mehreren Seiten geliefert. Hier lässt sich mit dem `size`-Parameter die Anzahl der Treffer pro Seite setzen (default: 10 Treffer) und über den `from`-Parameter die Nummer des Treffers, ab dem die Liste beginnen soll. Wir können uns aber auch die gesamte Ergebnisliste als [JSON Lines](http://jsonlines.org/) ausgeben lassen, indem wir den Parameter `format=jsonl` verwenden.

Das heißt, mit folgendem Query-String können wir die gesamten NWBib-Daten (1,9 GB) abziehen: `q=inCollection.id:"http://lobid.org/resources/HT014176012#!"&format=jsonl`

Bei dem Umfang lohnt es sich, die Daten gepackt (223 MB) herunterzuladen. Dies geht über cURL wie folgt (die Sonderzeichen in der URL müssen in diesem Fall vollständig escapet werden):

`$ curl --header "Accept-Encoding: gzip" "http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22&format=jsonl" > nwbib.gz`

# lobid-Datenmodell

Das Datenmodell der bibliographischen Daten in lobid ist mittlerweile recht komplex. Wir nutzen ein lobid-spezifisches Applikationsprofil aus DC Terms, Bibframe, Bibliographic Ontology und anderen Vokabularen (wer sich für so etwas interessiert, siehe [diesen Beitrag](http://blog.lobid.org/2017/04/19/vocabulary-choices.html)). Die wichtigsten Felder für eine elementare Anzeige eines Titels seien im Folgenden genannt, am Beispiel eines Aufsatzes ["Notwendiges Übel – das Abortgebäude der Zeche Zollern II/IV"](http://lobid.org/resources/HT014198549). Bei Fragen zu weiteren Feldern sei auf die [lobid-API-Dokumentation](https://lobid.org/resources/api#jsonld) verwiesen. Wir beantworten auch gerne Fragen zum Datenmodell.

## Titel / `title`

Das ist der Hauptitel eines bibliographischen Eintrags, im Beispiel "Notwendiges Übel". Eine Suche nach Titel (inklusive Eingrenzung auf die NWBib-Daten) sieht zum Beispiel so aus: [`inCollection.id:"http://lobid.org/resources/HT014176012#!" AND title:"Notwendiges Übel"`](https://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22+AND+title%3A%22Notwendiges+%C3%9Cbel%22).

Beispiel:

`"title": "Notwendiges Übel"`

## Titelzusatz / `otherTitleInformation`

Das ist ein Zusatz zum Titel, den viele Publikationen haben, oft eine Art Untertitel.

Beispiel:

`"otherTitleInformation":[
   "das Abortgebäude der Zeche Zollern II/IV"
]`

## Beitragende / `contribution`

Ein Array mit den Beiträgen von Personen oder Körperschaften (Organisationen) zu der Ressource und den jeweiligen Rollen. In jedem `contribution`-Objekt findet sich ein `agent`-Objekt, das den Akteur spezifiziert (meist inklusive Link auf die Gemeinsame Normdatei, GND) plus ein `role`-Objekt mit der Rolle. Der Name von beitragenden Akteuren findet sich in `contribution.agent.label`. Im Beispiel haben wir zwei Personen, die als Autor*innen agieren.

```json
{
   "contribution":[
      {
         "type":[
            "Contribution"
         ],
         "agent":{
            "id":"http://d-nb.info/gnd/114263221",
            "type":[
               "Person"
            ],
            "gndIdentifier":"114263221",
            "label":"Gärtner, Ulrike"
         },
         "role":{
            "id":"http://id.loc.gov/vocabulary/relators/cre",
            "label":"Autor/in"
         }
      },
      {
         "type":[
            "Contribution"
         ],
         "agent":{
            "id":"http://d-nb.info/gnd/112181201",
            "type":[
               "Person"
            ],
            "dateOfBirth":"1954",
            "gndIdentifier":"112181201",
            "label":"Kift, Dagmar"
         },
         "role":{
            "id":"http://id.loc.gov/vocabulary/relators/cre",
            "label":"Autor/in"
         }
      }
   ]
}
```

Weitere mögliche Rollen sind etwa Herausgeber oder Illustrator, siehe für einen Eintrag mit vielen unterschiedlichen Rollen z.B. [https://lobid.org/resources/HT020116943](https://lobid.org/resources/HT020116943).

## Publikationsjahr / `publication.startDate`

Im Feld `publication.startDate` findet sich das Erscheinungsdatum einer Ressource.

Beispiel:

```json
{
   "publication":[
      {
         "type":[
            "PublicationEvent"
         ],
         "startDate":"2004"
      }
   ]
}
```

Bei einer Abfrage des Publikationsjahrs können wir auch Zeiträume eingrenzen, z.B. eine Suche nach Titeln zum Thema [Gewerkschaften](https://nwbib.de/subjects#N543480) aus dem Zeitraum 2000 bis 2009: [`inCollection.id:"http://lobid.org/resources/HT014176012#!" AND subject.id:"https://nwbib.de/subjects#N543480" AND publication.startDate:[2000 TO 2009]`](http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22+AND+subject.id%3A%22https%3A%2F%2Fnwbib.de%2Fsubjects%23N543480%22+AND+publication.startDate%3A%5B2000+TO+2009%5D)

## Quellenangabe bei Aufsätzen / `bibliographicCitation`

Bei Aufsätzen ist die Angabe der Publikation sinnvoll, in der der Aufsatz erschienen ist. Die entsprechenden Informationen finden sich im Feld `bibliographicCitation`.

Beispiel:

`"bibliographicCitation":"Forum Industriedenkmalpflege und Geschichtskultur. - 2004, 2, S. 44-45 : Ill."`


# NWBib-Ortssystematik und Wikidata

[96% aller NWBib-Titel haben einen Bezug zu einem Ort](https://lobid.org/resources/search?q=_exists_%3Aspatial+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22), d.h. sie behandeln als Thema einen Landkreis, einen Stadtteil, einen Kirchenkreis, eine Grafschaft etc. Der Ortsbezug eines Eintrags findet sich im `spatial`-Objekt, siehe z.B. [https://lobid.org/resources/HT019559235.json](https://lobid.org/resources/HT019559235.json):

```json
{
   "spatial":[
      {
         "focus":{
            "id":"http://www.wikidata.org/entity/Q1295",
            "geo":{
               "lat":51.513888888889,
               "lon":7.4652777777778
            },
            "type":[
               "http://www.wikidata.org/entity/Q22865",
               "http://www.wikidata.org/entity/Q1549591",
               "http://www.wikidata.org/entity/Q253030",
               "http://www.wikidata.org/entity/Q707813",
               "http://www.wikidata.org/entity/Q42744322"
            ]
         },
         "id":"https://nwbib.de/spatial#Q1295",
         "type":[
            "Concept"
         ],
         "label":"Dortmund",
         "notation":"05913000",
         "source":{
            "id":"https://nwbib.de/spatial",
            "label":"Raumsystematik der Nordrhein-Westfälischen Bibliographie"
         }
      }
   ]
}
```

Die `id` im `spatial`-Objekt (im Beispiel `https://nwbib.de/spatial#Q1295`) verweist auf einen Eintrag in der [NWBib-Raumsystematik](https://nwbib.de/spatial), die alle Orte hierarchisch gliedert, auf die NWBib-Titel Bezug nehmen. Mit `spatial.focus.id` wird der entsprechende Wikidata-Eintrag zu dem Ort angegeben (hier `http://www.wikidata.org/entity/Q1295`).\* Zudem finden sich im `spatial.focus`-Objekt Geokoordinaten aus Wikidata und die Klassen, denen das Wikidata-Objekt zugeordnet wurde. Über die Links können weitere Informationen bei Wikidata geholt werden.

Wikidata wiederum beinhaltet Verknüpfungen zur NWBib. Alle Wikidata-Ortseinträge, die sich auch in der NWBib-Ortssystematik wiederfinden, verlinken mit der Property [P6814 "NWBib ID"](https://www.wikidata.org/wiki/Property:P6814) auf den jeweiligen Systematikeintrag, siehe z.B. den Wikidata-Eintrag zu [Dortmund-Bövinghausen](https://www.wikidata.org/wiki/Q1250595). Da [Wikidata](https://codingdavinci.de/daten/#wikidata) ein weiteres Datenset ist, das im CdV Westfalen-Ruhrgebiet genutzt wird, ergeben sich hier einige Möglichkeiten der gegenseitigen Anreicherung.

# Beispiele & Ideen

Zum besseren Verständnis zeigen wir hier anhand einiger Beispiele und Ideen, was mit den NWBib-Daten alles möglich ist.

## Kartenvisualisierung auf Basis der Orts- und Geodaten aus Wikidata

Mit den oben beschriebenen Wikidata-Ortsdaten in der NWBib lassen sich mit wenig Aufwand Visualisierungen erstellen, z.B. eine [Karte mit Raumbezügen](/data/nwbib-at-cdv.html) zu bestimmten Suchanfragen (die HTML-Datei enthält die komplette Umsetzung und kann als Ausgangsbasis für eigene Ideen verwendet werden) oder eine [Heatmap](http://lobid.org/download/heatTest1.html) aller Ortsbezüge (siehe hier die im Beispiel verlinkte allgemeine Dokumentation zur Erstellung vergleichbarer Heatmaps).

## Orte und Personen

In den anderen CdV-Datensets tauchen immer wieder Orte und Personen auf, die auch in der NWBib behandelt werden. Hier ein paar Beispiele:

- Im [Volksliedarchiv zu Westfalen](https://codingdavinci.de/daten/#volkskundliche-kommission-fur-westfalen-landschaftsverband-westfalen-lippe) tauchen in den Liednamen etwa folgende Orte auf:
  - Espelkamp: [https://nwbib.de/spatial#Q182691](https://nwbib.de/spatial#Q182691)
  - Natzungen: [https://nwbib.de/spatial#Q1971675](https://nwbib.de/spatial#Q1971675)
  - Vreden: [https://nwbib.de/spatial#Q200528](https://nwbib.de/spatial#Q200528)
- In [euregio-history.net](https://codingdavinci.de/daten/#euregiohistory) gibt es die Spalten 'field_place' und 'field_regions'. Die dort eingetragenen Orte finden sich häufig in der NWBib-Raumsystematik/in Wikidata.
- Über das [Freilichtmuseum Detmold](https://codingdavinci.de/daten/#lwl-freilichtmuseum-detmold) und die Gebäude dort gibt es [176 Einträge](https://nwbib.de/search?subject=http%3A%2F%2Fd-nb.info%2Fgnd%2F605200-9) in der NWBib.

Was lässt sich aus der Anschlussfähigkeit der NWBib an die anderen Datensets machen? Zum Beispiel kann die NWBib herangezogen werden, um in einer Anwendung auf weiterführende Literatur zu einem Ort oder einer Person zu verweisen.

# Kontaktieren Sie das lobid-Team

Bei Unklarheiten, Bugs und Fragen jeglicher Art stehen wir gerne zur Verfügung: [Mastodon](https://openbiblio.social/@lobid), [Twitter](https://twitter.com/lobidOrg), [IRC](irc://irc.freenode.net/lobid), [E-Mail](semweb@hbz-nrw.de).


----

\*<small> Tatsächlich wird die Ortssystematik zum größten Teil aus Wikidata generiert und dort entsprechend gepflegt.</small>
