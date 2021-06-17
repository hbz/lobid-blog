---
layout: post
title: "Reconciliation mit lobid, OpenRefine und Cocoda bei der GNDCon"
author: Adrian Pohl, Fabian Steeg, Jakob Voß
tags: lobid-gnd
---

Es sind Konferenzwochen. In der letzten Woche fand die [GNDCon 2.0](https://wiki.dnb.de/display/GNDCON/GNDCon) statt. Die zweite Ausgabe der GNDCon wurde dezentral veranstaltet. Verschiedene Akteure übernahmen dabei die inhaltliche Umsetzung und kümmerten sich um das technische Hosting für eine "MiniCon". Wir haben gemeinsam mit Jakob Voß von der Verbundzentrale des GBV die [MiniCon "Wie verlinken wir unsere Daten mit der GND?"](https://wiki.dnb.de/x/qx0RD) angeboten.

## Reconciliation als grundlegende Anforderung bei der Datenanreicherung

Übergeordnetes Thema der MiniCon war "Reconciliation", für das es im Deutschen kein gleichwertiges Wort gibt. Adrian bestimmte in seinem [Einleitungsvortrag](https://pad.gwdg.de/p/gndcon2021-reconciliation-i) Reconciliation wie folgt:

> "Reconciliation ist ein Prozess zum Abgleich von Namen und ggf. weiteren Attributen (einer Person, eines Ortes, eines Schlagworts etc.) mit jeweils einem Eintrag innerhalb einer Normdatei

Anwendungsfälle gibt es viele, allein schon im Kontext der Gemeinsamen Normdatei (GND) wollen viele Akteure aus Museen und Archiven oder etwa den Digital Humanities eigene Daten mit der GND verknüpfen. Der große Bedarf an Möglichkeiten zur Reconciliation mit Normdatenquellen – nicht nur im Bibliotheksbereich – wurde von der Community erkannt und hat zur Gründung einer [Entity Reconciliation Community Group](https://www.w3.org/community/reconciliation/) im Rahmen des World Wide Web Consortium (W3C) geführt. Das lobid-Team ist mit Fabian in der Gruppe vertreten, der auch die Rolle eines Co-Chairs übernommen hat, siehe auch seinen Blogbeitrag ["Supporting reconciliation from a library perspective"](https://www.w3.org/community/reconciliation/2021/01/04/supporting-reconciliation-from-a-library-perspective/).

Die Entity Reconciliation CG zielt mittelfristig ab auf die [Spezifikation](https://reconciliation-api.github.io/specs/latest/) eines allgemeinen Protokolls für webbasierte Reconciliation-Dienste. In einem ersten Schritt wird zunächst die bestehende API der Reconciliation-Schnittstellen für [OpenRefine]() spezifiziert. OpenRefine ist – zumindest im Bibliotheksbereich – wahrscheinlich das meistbenutzte und bewährte Werkzeug für Rconciliationprozesse. Als generisches tabellenbasiertes Werkzeug zur Bereinigung und Transformation von Daten ermöglicht OpenRefine eben auch die Verknüpfung von eigenen Daten mit verschiedenen Normdatenquellen und die darauf folgende Anreicherung aus den verknüpften Normdaten.

## OpenRefine Reconciliation mit lobid-gnd

Die Möglichkeiten von OpeRefine stellte Fabian in seiner [Präsentation](https://slides.lobid.org/2021-gndcon-reconcile/) anhand der [Reconciliation-Schnittstelle von lobid-gnd](https://lobid.org/gnd/reconcile) vor.

## Reconciliation von Normdaten untereinander mit Cocoda



## Diskussion
