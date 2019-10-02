---
layout: post
title: "NWBib-Daten für Coding da Vinci"
author: Adrian Pohl
tags: lobid-resources
---

Der Hackathon "[Coding da Vinci (CdV)](https://codingdavinci.de/)" wird seit 2014 jährlich in Deutschland ausgerichtet. Ziel von CdV ist es Entwickler\*innen zu motivieren, Anwendungen zu erarbeiten, in denen offene Daten aus Kultureinrichtungen nutzbar gemacht werden. Wir haben über die Jahre die verschiedenen [CdV Hackathons](https://codingdavinci.de/dokumentation/) beobachtet und immer wieder überlegt, Daten beizutragen. Jetzt ist es endlich so weit: Zum Hackathon ["Coding da Vinci Westfalen-Ruhrgebiet"](https://codingdavinci.de/events/westfalen-ruhrgebiet/) bieten wir die [Nordrhein-Westfälische Bibliographie (NWBib)](https://nwbib.de) als [Datenset](https://codingdavinci.de/daten/#hochschulbibliothekszentrum-des-landes-nordrhein-westfalen) an, das die Teilnehmer\*innen für ihe Anwendungen verwenden können. Die Möglichkeiten zur Nutzung der NWBib-Daten sind leider bisher nicht optimal dokumentiert sind. Dieser Beitrag soll die Situation verbessern.

# Die NWBib

Die NWBib ist eine Regionalbibliographie.

> Als Regionalbibliografie oder Landesbibliografie versteht man die systematische bibliografische Erfassung der Publikationen (vorrangig Bücher und Aufsätze) über eine Region. Der Begriff Landesbibliographie bezieht sich meist auf ein deutsches Bundesland, während Regionalbibliographien für Teile eines Bundeslandes oder sogar grenzübergreifend (beispielsweise die Bodenseebibliographie) erstellt werden.

Quelle: [https://de.wikipedia.org/wiki/Regionalbibliografie](https://de.wikipedia.org/wiki/Regionalbibliografie)

Da die NWBib die Landesbibliographie für Nordrhein-Westfalen ist, verzeichnet sie Literatur über das Land Nordrhein-Westfalen, seine Regionen, Orte und Persönlichkeiten. Neben Büchern werden vor allem Aufsätze erfasst sowie Landkarten, DVDs und viele andere Medientypen. Sie existiert seit 1983 und weist Literatur seit eben diesem Erscheinungsjahr nach. Das heißt, Publikationen, die vor 1983 erschienen sind, lassen sich dort nicht finden. Derzeit umfasst die Bibliographie etwa 420.000 Einträge.

**Nur Metadaten, keine Objekte**

Eine Bibliographie ist allein ein Nachweisinstrument. Das heißt, sie sammelt lediglich die Beschreibungen von Publikationen und keine Volltexte. Lediglich [bei knapp 30.000 Titeln findet sich ein Link auf den Vollext](http://lobid.org/resources/search?q=_exists_%3AfulltextOnline+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22).

# Die NWBib als Teil des Verbundkatalogs

Die Redaktion der NWBib in den Universitäts- und Landesbibliotheken Düsseldorf und Münster (mit Unterstützung der Universitäts- und Landesbibliothek Bonn) nutzt gängige bibliothekariache Erschließungsstandards (Resource Description and Access, RDA) zur Erfassung der Titel. Die Daten werden als Teil des [hbz-Verbundkatalogs](https://de.wikipedia.org/wiki/Hbz-Verbunddatenbank) gepflegt. Mit [lobid-resources](https://lobid.org/resources) stellt das Hochschulbibliothekszentrum des Landes-Nordrhein-Westfalen (hbz) den Verbundkatalog unter einer CC0-Lizenz als Linked Open Data u.a. über eine Web-API bereit. Im folgenden zeigen wir, welche Informationen in der NWBib verzeichnet sind und wie die Daten über die lobid-resources-API abgefragt werden können.

# Abfragen der NWBib-Daten: die Weboberfläche

Bevor man direkt in die JSON-Daten einsteigt, ist es sinnvoll, sich zunächst ein bisschen mit der NWBib über die Weboberfläche vertraut zu machen. Dies gibt einen guten Einblick über die Metadaten dahinter und was damit alles möglich ist. Eine Beschreibung

Die Startseite des Webauftritts unter [nwbib.de](https://nwbib.de) bietet ein Suchfeld für den einfachen Einstieg, eine Beschreibung der NWBib sowie eine Karte für die direkte Eingrenzung der NWBib-Titel nach Ortsbezug, bei der zwischen Kreis- oder Gemeindeebene gewählt werden kann:

![Startseite](/images/nwbib-at-cdv/nwbib-startseite.png "Startseite")

Ein Klick auf die Stadt "Essen" in der Karte z.B. gibt alle NWBib-Titel zurück, die über Orte, Personen, Veranstaltungen etc. innerhalb der Grenzen Essens handeln. Eine [Suche nach "Essen"](https://nwbib.de/search?q=essen) ist da unspezifischer und gibt beispielsweise auch – aufgrund von [Stemming](https://de.wikipedia.org/wiki/Stemming) im zugrundeliegenden Suchmaschinenindex – Artikel von "Hartmut Esser" zurück.

![Einfache Suche](/images/nwbib-at-cdv/suche.png "Einfache Suche in der NWBib nach 'Essen'")

Ein Suchergebnis lässt sich auf der rechten Seite über verschiedene Filter eingrenzen: nach Erscheinungsjahr, nach Raumbezug über eine Karte oder über Ortsnamen aus der [NWBib-Raumsystematik](https://nwbib.de/spatial), nach Sachgebieten aus der [NWBib-Sachsystematik](https://nwbib.de/subjects) , nach Schlagwörtern der [Gemeinsamen Normdatei](http://lobid.org/gnd), nach Medien- und Publikationstypen sowie nach Bestand in bestimmten Bibliotheken.

Wir laden dazu ein, einfach mal mit der Oberfläceh rumzuspielen und die NWBib-Titel ein wenig zu erkunden.

# Abfragen der NWBib über die lobid-API

In diesem Abschnitt werden die grundlegenden Möglichkeiten zur Abfrage der NWBib-Daten gezeigt.

## Eingrenzen auf NWBib

Die lobid-resources-API ist hier dokumentiert: [https://lobid.org/resources/api](https://lobid.org/resources/api). Wir wollen aber nicht in den mehr als 20 Millionen Verbunddaten suchen, sondern nur auf die NWBib-Daten zugreifen. Wie funktioniert das?

Jeder NWBib-Titel hat folgende Informationen im JSON, siehe etwa dieses [Beispiel](http://lobid.org/resources/HT019030132.json):

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

Ich kann jedes Feld abfragen. Ist es tiefer geschachtelt, gebe ich den Pfad per Punktnotation an, im Beispiel `inCollection.id`. Für die Eingrenzung einer Suche auf NWBib-Titel muss ich also jeweils folgendes ergänzen: [`inCollection.id:"http://lobid.org/resources/HT014176012#!"`](http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22)

## Inhaltstypen, Paging, Bulk Download

Die oben genannte Abfrage gibt über den Browser eine HTML-Sicht zurück, über cUrl o.ä. wird automatisch JSON(-LD) geliefert. Durch Ergänzung von `format=json` lässt sich die Rückgabe von JSON auch im Browser erzwingen, z.B. [`inCollection.id:"http://lobid.org/resources/HT014176012#!"&format=json`](http://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22&format=json)

Ergebnislisten werden in der Regel auf mehreren Seiten geliefert, mit dem `size`-Parameter lässt sich die Anzahl der Treffer pro Seite setzen (default: 10 Treffer) udn über den `from`-Parameter die Nummer des Treffers, ab dem die Liste beginnen soll. Ich kann mir aber auch die gesamte Ergebnisliste als [JSON Lines](http://jsonlines.org/) ausgeben lassen, indem ich den Parameter `format=jsonl` verwende.

Das heißt, mit folgender Abfrage kann ich die gesamten NWBib-Daten (1,9 GB) abziehen: `inCollection.id:"http://lobid.org/resources/HT014176012#!"&format=jsonl`

# NWBib und Wikidata

Mehr als drei Viertel der NWBib-Titel haben einen Bezug zu einem Ort, d.h. sie behandeln als Thema etwa einen Landkreis, einen Stadteil, einen Kirchenkreis, eine Grafschaft etc. Alle Orte, die NWBib von NWBib-Titeln behandelt werden, sind in der [NWBib-Raumsystematik](https://nwbib.de/spatial) gegliedert.

- Fast alle Orte, haben ein Verknüpfung zu Wikidata mit `foaf:focus`.
- Zudem sind NWBib-Titel mit der GND erschlossen, die wiederum oftmals in Wikidata angegeben ist. Bsp.
- Wikidata ist auch ein Datenset, das im CdV genutzt wird. Daraus ergeben sich einige Möglichkeiten.

# Beispiele

Zum besseren Verständnis zeigen wir hier anhand einiger Beispiele, was mit den NWbib-Daten alles möglich ist.

## Orte und Personen

In den anderen Datensets tauchen immer wieder Orte und Personen auf, die auch in der NWBib behandelt werden.

### Volksliedarchiv zu Westfalen

Generell: Sachsystematik "Volkslied" -> https://nwbib.de/search?nwbibsubject=https%3A%2F%2Fnwbib.de%2Fsubjects%23N706230

https://codingdavinci.de/daten/#volkskundliche-kommission-fur-westfalen-landschaftsverband-westfalen-lippe

Orte aus den Titeln:

- Espelkamp: https://nwbib.de/spatial#Q182691
- Natzungen: https://nwbib.de/spatial#Q1971675
- Vreden: https://nwbib.de/spatial#Q200528

### euregio-history.net

Orte/Regionen aus den Spalten 'field_place', 'field_regions' finden sich häufig in der NWBib-Raumsystematik/in Wikidata.

### Gebäude im Freilichtmuseum

https://codingdavinci.de/daten/#lwl-freilichtmuseum-detmold

## Kartenvisualisierung auf Basis


