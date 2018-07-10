---
layout: post
title: "lobid-gnd: Suche und Navigation"
date: 2018-07-04
author: Fabian Steeg, Adrian Pohl
tags: lobid-gnd
---

Dieser Artikel bietet einen Überblick zur Suche und Navigation in [lobid-gnd](http://lobid.org/gnd). Die Startseite von lobid-gnd führt auf die einfache Suchoberfläche:

![http://lobid.org/gnd](/images/lobid-gnd-suche/1-1-suchen.png)

Nach der Eingabe im Suchfeld kann einer der Vorschläge direkt ausgewählt werden, um zur Detailansicht zu gelangen:

![http://lobid.org/gnd](/images/lobid-gnd-suche/1-2-vorschlag-auswahl.png)

Alternativ kann eine Suche über die Enter-Taste oder das Lupen-Icon ausgeführt werden:

![http://lobid.org/gnd](/images/lobid-gnd-suche/1-3-vorschlag-suche.png)

Als alternativer Einstieg kann die gesamte GND erkundet werden:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/2-erkunden.png)

Über beide Wege kommt man zur Trefferliste. Über den Treffern auf der linken Seite kann die Anzahl der Treffer pro Seite gewählt werden, darunter kann zwischen den Seiten gewechselt werden:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/3-1-liste-paginierung.png)

Auf der rechten Seite ermöglicht eine facettierte Suche nach Entitätstyp, GND-Sachgruppe, Ländercode und Beruf oder Beschäftigung eine Eingrenzung der Ergebnisse:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/3-2-liste-facetten.png)

Als Standard werden in jeder Facette die fünf häufigsten Einträge angezeigt, weitere Einträge lassen sich ein- und ausblenden:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/4-facetten-einblenden.png)

Entitätstypen sind in Untertypen differenziert:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/5-facetten-untertypen.png)

Über die Auswahl unterschiedlicher Facetten lässt sich die Treffermenge präzise eingrenzen, z.B. zur Anzeige [aller hydrologischen Geografika in Nordrhein-Westfalen](http://lobid.org/gnd/search?filter=%2B(type%3ANaturalGeographicUnit)+%2B(gndSubjectCategory.id%3A%22http%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fgnd-sc%2319.3%22)+%2B(geographicAreaCode.id%3A%22http%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fgeographic-area-code%23XA-DE-NW%22)):

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/6-1-facetten-filter.png)

Erweiterte Suchmöglichkeiten ergeben sich aus einer Kombination von Sucheinstieg über das Suchfeld und facettierter Suche sowie über Mehrfachauswahl innerhalb einer Facette:

![http://lobid.org/gnd/search](/images/lobid-gnd-suche/6-2-facetten-filter.png)

Der Klick auf einen Suchtreffer führt zu einer Detailansicht. Die Detailseiten enthalten Links zu verknüpften GND-Einträgen. Über die Lupen-Icons kann eine Suche nach Einträgen mit der gleichen Beziehung angestoßen werden, z.B. [alle Teile der Nordsee](https://lobid.org/gnd/search?q=broaderTermPartitive.id%3A%22http%3A%2F%2Fd-nb.info%2Fgnd%2F4042579-4%22&size=50&format=html):

![http://lobid.org/gnd/4393546-1](/images/lobid-gnd-suche/7-1-details-lupe.png)

Die visuelle Darstellung im Tab "Beziehungen" erlaubt ebenso eine Navigation zu den verknüpften Entitäten per Klick auf einen Knoten des Graphs und eine Suche nach weiteren Einträgen mit der gleichen Beziehung per Klick auf eine Kante:

![http://lobid.org/gnd/4393546-1](/images/lobid-gnd-suche/7-2-details-kante.png)
