---
layout: post
title: "Zum Umstieg von lobid-resources auf Alma-basierte Daten"
author: Tobias Bülte, Adrian Pohl
date: 2023-04-11
tags: lobid-resources
---


Seit Ende 2019 arbeiten das hbz und die NRW-Verbundbibliotheken im [GO:AL-Projekt](https://www.hbz-nrw.de/projekte/goal-cbms) am Umstieg auf Alma als landesweit einheitliches cloudbasiertes Bibliotheksmanagementsystem. Im Rahmen von fünf Waves migrieren alle Verbundbibliotheken auf Alma. Mit der anstehende dritten Wave wird Aleph durch eine Community Zone in Alma als primäres Verbundsystem abgelöst, das sämtliche Verbunddaten samt Beständen vorhält. Im Zuge dessen wird auch [lobid-resources](https://lobid.org/resources) nicht mehr mit Aleph, sondern mit Alma-Daten gefüttert.

Das lobid-Team arbeitet schon seit langer Zeit auf diesen Umstieg hin. Wir haben eine lobid-resources-Instanz auf Basis der Alma-Daten aufgesetzt und nach und nach verbessert. Das Ergebnis läuft momentan unter [https://alma.lobid.org/resources](https://alma.lobid.org/resources). Im Zuge dieser Migration haben wir die neu Fix-Sprache für die Datentransformation mit [Metafacture](https://metafacture.org) entwickelt und angewendet. Die recht komplexe Transformation von 24 Millionen Verbunddatensätzen bedeutete dabei den Lackmustest für Metafacture-Fix.

## Erste Tests waren erfolgreich

Wir sind zuversichtlich, dass der Umstieg für die meisten lobid-resources-Nutzer:innen recht reibungslos ablaufen wird. Einige hbz-interne Systeme und auch die Nutzung der lobid-Daten im Discovery-System der TU Dortmund wurden bereits testweise umgestellt: Das lobid-resources UI wurde bereits entsprechend angepasst wie auch die Nordrhein-Westfälische Bibliographie (NWBib).

Dementsprechend sind wir sehr zuversichtlich, dass auch alle anderen Anwendungen, die auf lobid-resources zugreifen mit relativ geringem Aufwand weiterlaufen können.

## Ziel: Rückwärtskompatibilität mit minmalen Anpassungen

Beim Umstieg auf Alma-basierte Daten haben wir uns also oberstes Ziel gesetzt, die lobid-resources-API möglichst rückwärtskompatibel zu machen, d.h. so wenig wie möglich Änderungen am Datenmodell und den API Calls vorzunehmen. Um ein paar Änderungen und die Korrektur ungünstiger vergangener Entscheidungen bei der Datenmodellierung sind wir aber nicht herumgekommen. Auch ist eine grundlegende Änderung, dass zukünftig Alma-basierte Identifikatoren für die Ressourcen-URIs genutzt werden. Desweiteren wurden Änderungen durch die veränderte Datenbasis (MARC statt MAB-orientiert) zustande.

Hier eine Übersicht über die stattgefundenen Änderungen:
- `id` (HTTP-URI zur Identifizierung der bibliographischen Ressourcen) wird jetzt nicht auf Basis der HBZ-ID konstruiert, sondern auf Basis der ALMA-MMS-ID des jewiligen Records. (siehe [#1693](https://github.com/hbz/lobid-resources/issues/1693))
- Bei den Holding-Angaben werden nur noch teilweise die Institutionsbibliotheken explizit mithilfe einer ISIL angegeben, da durch die ALMA-Migration des Verbunds die Datenlage vereinfacht wurde. Nur noch Bibliotheken, die explizit Mappings für ihre "Sublibraries" bereitstellen, werden auch entsprechend verlinkt. (siehe []())
- zwei Elemente zur Verlinkung zu anderen Resourcen bzw. externen Materialien u.a. aufgrund unklarer Definition und fehlendem Mehrwert wurden gelöscht:
   - `hasVersion`
   - `similar`
- `owl:sameAs` und `umbel:isLike` wurden als `sdo:sameAs` zusammen geführt. (siehe [#1400](https://github.com/hbz/lobid-resources/issues/1400))
- `titleOfSubSeries` wurde gelöscht und die Werte werden an `title` angehangen
- das Hilfsfeld `subjectAltLabels` wurde gelöscht, da die varianten Namen jetzt eindeutig einem konkreten Schlagworteintrag unter `subject` zugeordnet werden können
- `publication.location` ist jetzt ein Array
- einige nicht mehr benötigte NWBib-Felder bzw. fehlerhafte Felder wurden gelöscht:
  - `longitudeAndLatitude[].*`
  - `coverage[].*`
  - `spatial[].*.focus.geo[].*.lat`
  - `spatial[].*.focus.geo[].*.lon`
  - `license[].*.note[].*`
- Die Unterfelder `exampleOfWork.creatorOfWork` und `exampleOfWork.instrumentation[].*` wurden gelöscht, da die Datenb
- Provenienzangaben in `describedBy` wurden umgestellt, da sich die Informationen auf den Eintrag im Verbundkatalog beziehen (`describedBy.resultOf.object`). Zudem ist `describedBy.resultOf.object.modifiedBy` jetzt ein Array.
- `corporateBodyForTitle[].*` ??
- falsche/überflüssige Felder in `contribution` wurden entfernt:
  - `contribution[].*.agent.altLabel`
  - `contribution[].*.agent.label[].*`
  - `contribution[].*.agent.source.id`
  - `contribution[].*.agent.source.label`
- `natureOfContent[].*.gndIdentifier`, `natureOfContent[].*.source.id`, `natureOfContent[].*.source.label`, `natureOfContent[].*.type[].*`

## Bitte testet eure Anwendungen

Um einen reibungslosten Umstieg Anfang Mai zu gewährleisten, bitten wir euch darum, in der zweiten Aprilhälfte alle eure Anwendungen zu testen, die gegen lobid-resources laufen.

