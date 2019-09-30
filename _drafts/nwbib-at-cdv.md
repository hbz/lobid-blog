layout: post
title: "NWBib-Daten für Coding da Vinci Westfalen-Ruhrgebiet"
date: 2019-10-03
author: Adrian Pohl
tags: nwbib
---

Zum Hackathon ["Coding da Vinci Westfalen-Ruhrgebiet"](https://codingdavinci.de/events/westfalen-ruhrgebiet/) bietet wir die Nordrhein-Westfälische Bibliographie (NWBib) als Datenset hat, dass die Teilnehmer*innen am Hackathon für ihe Anwendungen verwenden können. Da die Möglichkeiten zur Nutzung der NWBib-Daten bisher nicht optimal dokumentiert sind, möchten wir das in diesem Beitrag nachholen.

# Die NWBib

Die NWBib ist eine Regionalbibliographie.

> Als Regionalbibliografie oder Landesbibliografie versteht man die systematische bibliografische Erfassung der Publikationen (vorrangig Bücher und Aufsätze) über eine Region. Der Begriff Landesbibliographie bezieht sich meist auf ein deutsches Bundesland, während Regionalbibliographien für Teile eines Bundeslandes oder sogar grenzübergreifend (beispielsweise die Bodenseebibliographie) erstellt werden.

Quelle: [https://de.wikipedia.org/wiki/Regionalbibliografie](https://de.wikipedia.org/wiki/Regionalbibliografie)

Da die NWBib die Landesbibliographie für Nordrhein-Westfalen ist, verzeichnet sie Literatur über das Land Nordrhein-Westfalen, seine Regionen, Orte und Persönlichkeiten. Neben Büchern werden vor allem Aufsätze erfasst sowie Landkarten, DVDs und viele andere Medientypen. Sie existiert seit 1983 und weist Literatur seit eben diesem Erscheinungsjahr nach. Das heißt, Publikationen, die vor 1983 erschienen sind, lassen sich dort nicht finden. Derzeit umfasst die Bibliographie etwa 420.000 Einträge.

**Nur Metadaten, keine Objekte**

Eine Bibliographie ist allein ein Nachweisinstrument. Das heißt, sie sammelt lediglich die Beschreibungen von Publikationen und keine Volltexte. Lediglich [bei knapp 30.000 Titeln findet sich ein Link auf den Vollext](http://lobid.org/resources/search?q=_exists_%3AfulltextOnline+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22).

# Die NWBib als Teil des Verbundkatalogs

Die Redaktion der NWBib in den Universitäts- und Landesbibliotheken Düsseldorf und Münster (mit Unterstützung der Universitäts- und Landesbibliothek Bonn) nutzt gängige bibliothekariche Erschließungsstandards (Resource Description and Access, RDA) zur Erfassung der Titel. Die Daten werden als Teil des [hbz-Verbundkatalogs](https://de.wikipedia.org/wiki/Hbz-Verbunddatenbank) gepflegt. Mit [lobid-resources](https://lobid.org/resources) stellt das Hochschulbibliothekszentrum des Landes-Nordrhein-Westfalen (hbz) die den Verbundkatalog unter einer CC0-Lizenz als Linked Open Data u.a. über eine Web-API bereit. Im folgenden zeigen wir, welche Informationen in der NWbib verzeichnet sind wie die Daten über die lobid-resources-API abgefragt werden können.

# Abfragen der NWBib-Daten

Die lobid-resources-API ist hier dokumentiert: [https://lobid.org/resources/api](https://lobid.org/resources/api).

Download der kompletten NWBib zur lokalen Verarbeitung: `$ curl "https://lobid.org/resources/search?q=inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22&format=jsonl"`
