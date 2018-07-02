---
layout: post
title: "lobid-gnd-Neuigkeiten: Bulk Downloads, OpenRefine-API und mehr"
date: 2018-07-02
author: Adrian Pohl
---

Letzte Woche haben wir einige Funktionen zu lobid-gnd ergänzt, hier ein Überblick.

## Zufälliges Bild auf der Startseite

Wie auch in [lobid-organisations](https://lobid.org/organisations) wird nun auf der [lobid-gnd-Startseite](https://lobid.org/gnd) mit jedem Laden ein zufälliges Bild zu einer GND-Ressource geladen. Momentan gibt es [knapp 200.000 Einträge mit Bild](http://lobid.org/gnd/search?q=_exists_%3Adepiction), davon sind die meisten Personen. Wer also Lust hat, die GND ein wenig näher kennenzulernen, kann ja mal die Startseite ein paar Mal neu laden.

 [![Screenshot](/images/sendler.png "lobid-gnd homepage")](https://lobid.org/gnd)
 <small>Screenshot der lobid-gnd-Startseite mit dem Bild von [Irena Sendler](http://lobid.org/gnd/129335290)</small>

## Bulk Downloads

Für jede lobid-gnd-Abfrage kann jetzt – wie auch in lobid-resources – die gesamte Ergebnismenge als JSON Lines heruntergeladen werden, indem einach der Parameter `format=jsonl` ergänzt wird. Im Antwortformat wird dann pro Zeile ein GND-Eintrag zurückgeliefert, im Unterschied zu normalen Suchanfragen entfällt der `member`-Array, in dem ansonsten die Ergebnisse aufgelistet sind. Zum Beispiel alle GND-Entitäten vom Typ "Sammlung" (Unterklasse von "Werk"):

[http://lobid.org/gnd/search?filter=%2B%28type%3ACollection%29&size=100&format=jsonl](http://lobid.org/gnd/search?filter=%2B%28type%3ACollection%29&size=100&format=jsonl)

Bei solchen kleineren Ergebnismengen reicht der JSON-Lines-Download aus, werden größere Untermengen der GND abgefragt, empfiehlt es sich, das Ergebnis komprimiert als gzip herunterzuladen. Dafür muss der HTTP-Anfrage nur der entsprechende Accept-Header mitgegeben werden, z.B. mit curl:

`$ curl --header "Accept-Encoding: gzip" 'http://lobid.org/gnd/search?filter=%2B%28type%3ACollection%29&size=100&format=jsonl'`

## OpenRefine Reconciliation API

Seit Ende letzter Woche ist die OpenRefine Reconciliation API für lobid-gnd produktiv. Damit ist es auf einfache Weise möglich, mit dem für Datenaufbereitung und -anreicherung beliebten Werkzeug [OpenRefine](http://openrefine.org/) eine Liste von Ansetzungsformen mit der GND abzugleichen, um die Textstrings auf GND-IDs zu matchen. Dafür müssen lediglich die abzugleichenden Daten in OpenRefine geladen werden, die entsprechende Spalte ausgewählt und der Reconciliation-Prozess z.B. wie folgt durchgeführt werden.

1.Start des Reconciliation-Prozesses für eine Spalte in OpenRefine
![Screenshot](/images/start-reconciling.png "start reconciling")
2. Ergänzen des lobid-gnd Reconciliation Endpoints (`https://lobid.org/gnd/reconcile`) in OpenRefine
![Screenshot](/images/add-lobid-gnd-to-openrefine.png "ergänze lobid-gnd reconciliation API")
3. (Optionale) Auswahl einer GND-Untermenge (hier "Person") für Reconciliation
![Screenshot](/images/choose-type-for-reconciliation.png "Typ-Auswahl")
4. Start der API-Abfrage mit Klick auf "Start Reconciling"

