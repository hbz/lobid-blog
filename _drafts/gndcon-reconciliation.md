---
layout: post
title: "Reconciliation mit lobid, OpenRefine und Cocoda bei der GNDCon"
author: Adrian Pohl, Fabian Steeg, Jakob Voß
tags: lobid-gnd
---

In der letzten Woche fand die [GNDCon 2.0](https://wiki.dnb.de/display/GNDCON/GNDCon) statt. Die zweite Ausgabe der GNDCon wurde dezentral veranstaltet. Verschiedene Akteure übernahmen dabei die inhaltliche Umsetzung und kümmerten sich um das technische Hosting für eine "MiniCon". Wir haben gemeinsam mit Jakob Voß von der Verbundzentrale des GBV die [MiniCon "Wie verlinken wir unsere Daten mit der GND?"](https://wiki.dnb.de/x/qx0RD) angeboten.

## Reconciliation als Grundlage für die Verlinkung mit Normdaten

Grundlage einer solchen Verlinkung eigener Daten ist ein Abgleich dieser Daten mit der GND. Dieser zugrunde liegende Prozess des Datenabgleichs wird auch als _Reconciliation_ bezeichnet. Adrian bestimmte in seinem [Einleitungsvortrag](https://pad.gwdg.de/p/gndcon2021-reconciliation-i) Reconciliation wie folgt:

> "Reconciliation ist ein Prozess zum Abgleich von Namen und ggf. weiteren Attributen (einer Person, eines Ortes, eines Schlagworts etc.) mit jeweils einem Eintrag innerhalb einer Normdatei"

Anwendungsfälle gibt es viele, allein schon im Kontext der Gemeinsamen Normdatei (GND) wollen viele Akteure aus Museen und Archiven oder etwa den Digital Humanities eigene Daten mit der GND verknüpfen. Neben der GND gibt es eine größere Anzahl weiterer [Datenquellen, für die eine Reconciliationschnittstelle angeboten wird](https://reconciliation-api.github.io/testbench/). Der große Bedarf an Möglichkeiten zur Reconciliation mit Normdatenquellen – nicht nur im Bibliotheksbereich – wurde von der Community erkannt und hat zur Gründung einer [Entity Reconciliation Community Group](https://www.w3.org/community/reconciliation/) (CG) im Rahmen des World Wide Web Consortium (W3C) geführt. Das lobid-Team ist mit Adrian und Fabian in der Gruppe vertreten, siehe auch Fabians Blogbeitrag ["Supporting reconciliation from a library perspective"](https://www.w3.org/community/reconciliation/2021/01/04/supporting-reconciliation-from-a-library-perspective/).

Die Entity Reconciliation CG zielt mittelfristig auf die [Spezifikation](https://reconciliation-api.github.io/specs/latest/) eines allgemeinen Protokolls für den Datenabgleich im Web ab. In einem ersten Schritt wird zunächst die bestehende API der [Reconciliation-Funktionalität in OpenRefine](https://docs.openrefine.org/manual/reconciling) spezifiziert. OpenRefine ist – [auch im Bibliotheksbereich](https://openrefine.org/blog/2020/02/20/2020-survey-results.html) – eines der meistbenutzten und -bewährten Werkzeuge für Datenbereinigung und -abgleich und wird als [Essential Open Source Software for Science](https://openrefine.org/blog/2019/11/14/czi-eoss.html) gefördert. Als generisches tabellenbasiertes Werkzeug zur Bereinigung und Transformation von Daten ermöglicht OpenRefine auch die Verknüpfung mit verschiedenen Normdatenquellen und die darauf folgende Anreicherung aus den verknüpften Normdaten.

## Reconciliation von lokalen Daten und der GND mit OpenRefine

In seiner Präsentation zur [OpenRefine Reconciliation mit lobid-gnd](https://slides.lobid.org/2021-gndcon-reconcile/) gab Fabian zunächst einen Überblick zu den [Datenquellen](https://slides.lobid.org/2021-gndcon-reconcile/#/8) und der [Rechercheoberfläche](https://slides.lobid.org/2021-gndcon-reconcile/#/10) von lobid-gnd. Die Oberfläche dient hier zum Erkunden der Daten, deren Verständnis eine wichtige Grundlage für einen erfolgreichen Abgleich darstellt.

Im Anschluss wurde zunächst das [grundsätzliche Vorgehen](https://slides.lobid.org/2021-gndcon-reconcile/#/18) beim Datenabgleich mit der [Reconciliation-Schnittstelle](https://lobid.org/gnd/reconcile) von lobid-gnd in OpenRefine vorgestellt, sowie die darauf aufbauende [Anreicherung](https://slides.lobid.org/2021-gndcon-reconcile/#/33) auf Basis der abgeglichenen GND-Einträge.

Schließlich wurden [verschiedene Strategien](https://slides.lobid.org/2021-gndcon-reconcile/#/44) zur Verbesserung der Qualität des Abgleichs vorgestellt, insbesondere die [Verwendung zusätzlicher lokalen Daten](https://slides.lobid.org/2021-gndcon-reconcile/#/47) (z.B. Lebensdaten und Berufe) als Merkmale zur Disambiguierung der abzugleichenden Namen.

## Reconciliation von Normdaten untereinander mit Cocoda

Mit [Cocoda](https://coli-conc.gbv.de/de/cocoda/) wurde im zweiten Teil der MinCon eine Webanwendung vorgestellt, die ebenfalls die Reconciliation API verwendet, um passende Einträge in der GND oder in anderen Normdateien zu finden. Wie Jakob in [seiner Präsentation](https://coli-conc.gbv.de/publications/gndcon2021.pdf) und einer kurzen Live-Demo zeigte, ist Cocoda im Rahmen des Projekt coli-conc vor Allem entwickelt worden um verschiedene Klassifikationen durch Mappings aufeinander abzubilden. Herausgekommen ist allerdings auch eine Infrastruktur zum einheitlichen Zugriff auf unterschiedlichste Vokabulare, darunter GND, RVK, DDC und Wikidata.

In Cocoda lassen sich nicht nur Vokabulare auf die GND abbilden sondern auch vorhandene Mappings von und auf die GND durchsuchen. Eine Besonderheit von Cocoda ist, dass einzelne Mappings mit ihrer Provenienz gespeichert werden und mit einem Review-System auch komplexere Workflows zur Qualitätssicherung umgesetzt werden können. Der Vortrag schloss mit einem Vergleich von Cocoda und OpenRefine um Anhaltspunkte zu geben wann welches Werkzeug besser geeignet ist.

## Diskussion

Schon während der Vorträge entstand im Chat eine lebhafte Diskussion, die zum Teil in Pausen, zum Teil nach den Vorträgen im Plenum aufgegriffen wurde. Den vollständigen Chatverlauf und die Ergebniss von zwei Umfragen finden sich im [Etherpad](https://etherpad.lobid.org/p/gndcon2021) zu der Veranstaltung.

So wurde etwa das Einspielen eigener Daten angesprochen, wenn die GND keinen passenden Eintrag enthält. In OpenRefine lässt sich eine Liste von nicht gemappten Einträgen exportieren, um anschließend beispielsweise im GND-Redaktionsystem neue GND-Einträge zu erstellen. In Cocoda ist es möglich, zumindest auf übergeordnete Einträge zu mappen. Eine Vorschlagsfunktion für neue GND-Einträge ist in Cocoda angedacht, erfordert jedoch die Anbindung an eine Schreib-API für neue Begriffe. Solch eine API könnte auch in OpenRefine verwendet werden um direkt aus der Anwendung Ergänzungen in die GND aufzunehmen, vergleichbar mit der in OpenRefine enthaltenen [Extension zum Import in Wikidata](https://www.wikidata.org/wiki/Wikidata:Tools/OpenRefine/Editing/Tutorials/Basic_editing).

In der [Runde des Resümees](https://wiki.dnb.de/x/kAdND) am Ende des Tages wurde mit Vertreter*innen verschiedener technisch orientierter MiniCons über die technische Weiterentwicklung der GND diskutiert. Auch hier war der Datenabgleich ein Thema, insbesondere wurde die Bedeutung von Standards bei der Zusammenarbeit in einer verteilten Infrastruktur wie der GND-Kooperative betont. Zugleich wurde deutlich, dass vor dem Hintergrund der Pica-basierten GND mit zusätzlichem [Linked-Open-Data-Dienst](https://www.dnb.de/DE/Professionell/Metadatendienste/Datenbezug/LDS/lds_node.html) und der offenen lobid-gnd-API eine Konsolidierung sehr herausfordernd oder womöglich gar nicht anzustreben ist, sei es in Bezug auf GND-Webangebote als auch auf Datenformate für den Datenaustausch im Web.