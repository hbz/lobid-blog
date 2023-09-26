---
layout: post
title: Pflege und Verbesserung von lobid-organisations 
date: 2023-10-12
author: Adrian Pohl & Sebastian Meyer
tags: lobid-resources lobid-organisations lobid-gnd
---

To Do:
- Verweis auf https://blog.lobid.org/2022/07/19/survey-results.html
- Den folgenden noch für einen Blogbeitrag anpassen.

Dieses Dokument ist das Ergebnis einer Beauftragung von [Open Culture Consulting](https://www.opencultureconsulting.com/) durch das [Hochschulbibliothekszentrum des Landes Nordrhein-Westfalen (hbz)](https://www.hbz-nrw.de/) zur Erstellung von Nutzungsrichtlinien für die unter [lobid.org](https://lobid.org/) angebotenen Dienste und APIs. Es gliedert sich in vier Bereiche:

1. **Richtlinien einer rücksichtsvollen lobid-Nutzung**

   Hier werden unverbindliche Leitlinien zur Nutzung der lobid-Dienste formuliert, die darauf abzielen, die zur Verfügung stehenden Ressourcen möglichst gleichberechtigt allen Nutzenden zur Verfügung stellen zu können und zugleich die Leistung der die Daten kuratierenden Einrichtungen sowie dem hbz als Infrastrukturanbieter zu honorieren. Zudem soll die statistische Auswertung der Nachnutzung der Angebote ermöglicht werden - nicht zuletzt auch zur Rechtfertigung für die Aufrechterhaltung der Dienste gegenüber den jeweiligen Geldgebern. Es handelt sich jedoch um einen Appell zur Freiwilligkeit, dessen Maßnahmen in keinster Weise technisch oder juristisch erzwungen werden.

   Das Dokument richtet sich sowohl an Entscheider:innen als auch an implementierende Techniker:innen und sollte prominent auf der Webseite [lobid.org](https://lobid.org/) publiziert werden.

2. **Technische Hinweise zur lobid-Nutzung**

   Um die technische Umsetzung der in den Richtlinien beschriebenen Maßnahmen so niedrigschwellig wie möglich zu gestalten, werden in diesem Dokument Hinweise zur Implementierung gegeben und mit Kurzbeispielen illustriert. Auch diese Maßnahmen sind als Empfehlungen zu verstehen und werden seitens lobid nicht technisch erzwungen.

   Das Dokument richtet sich an implementierende Techniker:innen und sollte etwa Bestandteil der API-Dokumentationen ([lobid-resources](https://lobid.org/resources/api), [lobid-organisatons](https://lobid.org/organisations/api), [lobid-gnd](https://lobid.org/gnd/api)) sein.

3. **Informationen zur Gewährleistung**

   Dieser Absatz zum Gewährleistungsausschluss ist der einzige juristisch verbindliche Text und sollte daher analog zu Impressum und Datenschutzerklärung unabhängig von den vorgenannten Dokumenten publiziert werden.

   Eine vorherige Prüfung durch eine:n Justiziar:in ist angeraten, da der Text von juristischen Laien verfasst wurde.

4. **Empfehlungen zur Verbesserung des lobid-Angebots**

   Die eingangs beschriebenen Ziele einer möglichst niedrigschwelligen, gleichberechtigten Nutzung der lobid-Schnittstellen können auch seitens des hbz als Anbieter der Dienste durch eine Reihe von Maßnahmen weiter unterstützt werden. Einige Verbesserungsvorschläge sind hier aufgeführt.

Die Dokumente sind Ergebnisse eines Evaluierungsprozesses, an dem mehrere Fachexperten beteiligt waren. Zunächst führten Felix Lohmeier und Adrian Pohl eine anonyme [Umfrage unter Nutzenden der lobid-Dienste](https://blog.lobid.org/2022/02/03/umfrage.html) durch, deren [Ergebnisse](https://blog.lobid.org/2022/07/19/survey-results.html) den Status Quo der praktischen Anwendung der APIs widerspiegelten und erste Anhaltspunkte für in den Nutzungsrichtlinien zu adressierende Verbesserungspotentiale zeigten. Diese Aspekte wurden von Christian Erlinger in [Fachinterviews mit ausgewählten "Power Usern" der lobid APIs](https://docs.google.com/document/d/1p_kK69yEXcxlnBrg1rpp1HTgO9q-c56lz3a-0cJmi7w/edit) weiter vertieft.

Daneben evaluierte Jens Nauber die [Dokumentationen anderer Anbieter](https://docs.google.com/document/d/1kWFxz6Wc3Uy1X5P0WZPxpyyhhsIHzLzuadzcSNoz0Ho/edit) prominenter Schnittstellen im Bereich freier Kultur- und Forschungsdaten insbesondere unter dem Aspekt der über Nutzungsbedingungen gesteuerten fairen Verwendung der Dienste.

Auf Basis der Umfrageergebnisse, Fachinterviews und Evaluierung formulierten Leander Seige, Sebastian Meyer et al. schließlich die untenstehenden Richtlinien zur Nutzung, Hinweise zur Implementierung, Gewährleistungsausschluss sowie Verbesserungsvorschläge.