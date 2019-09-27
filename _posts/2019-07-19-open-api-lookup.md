---
layout: post
title: "Offene Bibliotheks-APIs erfassen & nachschlagen"
date: 2019-07-19
author: Adrian Pohl
tags: lobid-organisations
---

Bisher ist es oft nur recht umständlich herauszufinden, ob und welche Schnittstellen zu einem Bibliothekssystem existieren. Dies kann nun auf sehr bequeme Weise über die lobid-API erfolgen. Im Sigelverzeichnis lassen sich die API-Endpoints verschiedener offener Programmierschnittstellen erfassen und sind dann über [lobid-organisations](https://lobid.org/organisations) abfragbar.

Wir nehmen als Beispiel die Universitätsbibliothek Hildesheim (DE-Hil2), die ihre Schnittstellen ([SRU](http://www.loc.gov/standards/sru/), [DAIA](http://purl.org/NET/DAIA), [PAIA](https://gbv.github.io/paia/paia.html)) vorbildlich erfasst hat. Das [JSON-LD](https://lobid.org/organisations/DE-Hil2.json) enthält folgende Informationen:

```json
{
   "id":"http://lobid.org/organisations/DE-Hil2#!",
   "availableChannel":[
      {
         "serviceType":"SRU",
         "type":["ServiceChannel","WebAPI"],
         "serviceUrl":"http://sru.gbv.de/opac-de-hil2"
      },
      {
         "serviceType":"PAIA",
         "type":["ServiceChannel","WebAPI"],
         "serviceUrl":"https://paia.gbv.de/DE-Hil2/"
      },
      {
         "serviceType":"DAIA",
         "type":["ServiceChannel","WebAPI"],
         "serviceUrl":"https://paia.gbv.de/DE-Hil2/daia"
      }
   ]
}
```

Im `availableChannel` Array sind also nun alle im Sigelverzeichnis eingetragenen Service URLs als `ServiceChannel` angegeben, wobei nur Programmierschnittstellen den zusätzlichen Typ `WebAPI` haben.<sup>\*</sup> Mit `serviceType` wird der jeweilige Schnittstellentyp angegeben.

Alle Felder lassen sich über die API abfragen. Hier ein paar Beispiele:

- Einrichtungen, die mindestens eine offene API im Sigelverzeichnis dokumentiert haben: [`availableChannel.type:WebAPI`](https://lobid.org/organisations/search?q=availableChannel.type%3AWebAPI)
- Einrichtungen mit Angabe einer SRU-Schnittstelle: [`availableChannel.serviceType:SRU`](https://lobid.org/organisations/search?q=availableChannel.serviceType%3ASRU)
- Einrichtungen mit Angabe einer OpenURL-Schnittstelle: [`availableChannel.serviceType:OpenURL`](https://lobid.org/organisations/search?q=availableChannel.serviceType%3AOpenURL)
- Einrichtungen mit Angabe einer DAIA- oder PAIA-API: [`availableChannel.serviceType:DAIA OR availableChannel.serviceType:PAIA`](https://lobid.org/organisations/search?q=availableChannel.serviceType%3ADAIA+OR+availableChannel.serviceType%3APAIA)
- Einrichtungen mit verzeichneter DAIA-API aber ohne SRU-API: [`availableChannel.serviceType:DAIA AND NOT availableChannel.serviceType:SRU`](https://lobid.org/organisations/search?q=availableChannel.serviceType%3ADAIA+AND+NOT+availableChannel.serviceType%3ASRU)

Die Abfragen lassen sich natürlich beliebig mit der Abfrage anderer Felder (siehe die [API-Dokumentation](https://lobid.org/organisations/api/de#jsonld) kombinieren, zum Beispiel:

- Alle Zentralen Universitätsbibliotheken, die mindestens eine offene API im SIgelverzeichnis dokumentiert haben: [`availableChannel.type:WebAPI AND classification.id:"http://purl.org/lobid/libtype#n60"`](https://lobid.org/organisations/search?location=&from=0&size=20&q=availableChannel.type:WebAPI+AND+classification.id:%22http://purl.org/lobid/libtype%23n60%22)

Voraussetzung für eine umfassende Suche nach offenen Schnittstellen ist natürlich, dass die Schnittstellen überhaupt im Sigelverzeichnis erfasst sind, wozu wir ausdrücklich ermutigen möchten. Für die Erfassung hat Jakob Voß eine [Anleitung](https://verbundwiki.gbv.de/display/VZG/Schnittstellen) erstellt, die wir hier wiedergeben.

## Eintragung offener APIs im Sigelverzeichnis

Ob und unter welcher URL welche Schnittstellen zu Bibliothekssystemen existieren ist oft nur aufwändig herauszufinden. Es wird deshalb empfohlen die API-URLs im Sigelverzeichnis einzutragen. Grundlage hierfür ist das Pica3-Feld 856. Zur Eintragung und Aktualisierung kann das Webformular der Sigelstelle verwendet werden:

1. Eintrag der eigenen Bibliothek **im Sigelverzeichnis suchen** (z.B. [https://sigel.staatsbibliothek-berlin.de/suche/?isil=DE-Hil2](https://sigel.staatsbibliothek-berlin.de/suche/?isil=DE-Hil2))
1. Ganz unten auf "**Änderungen zu Angaben mitteilen**" klicken (z.B. [https://sigel.staatsbibliothek-berlin.de/aenderungen-mitteilen/?isil=DE-Hil2](https://sigel.staatsbibliothek-berlin.de/aenderungen-mitteilen/?isil=DE-Hil2))
1. Vorhandene Schnittstellen unter "Service-URLs" ergänzen
	1. Art der URL: "**weitere Service-URL**" auswählen
	1. Text (Textfeld direkt unter der Auswahlliste): Art der Schnittstelle, also "**SRU**", "**Z39.50**", "**DAIA**", "**PAIA**" oder "**OpenURL**"
	1. URL: Basis-URL der jeweiligen Schnittstelle
1. Formular abschicken (vorher noch eigene Kontaktdaten für Rückfragen angeben) & Bestätigungslink in der automatisch verschickten E-Mail klicken

<img src="/images/2019-07-19-apis-im-sigelverzeichnis.png" alt="Ein Screenshot des Änderungsformular, der beispielhaft das Eintragen von SRU, PAIA und DAIA-Endpunkten zeigt" style="width:650px">

Wer will kann natürlich auch den Link zum Änderungsformular im jeweiligen lobid-organisations-Eintrag klicken:

<a href="https://lobid.org/organisations/DE-Hil2"><img src="/images/2019-07-19-aenderungen-via-lobid.png" alt="Ein Screenshot, der zeigt, wie man aus einem lobid-organisations-Eintrag in das entsprechende Änderungsformular des Sigelverzeichnisses gelangt" style="width:650px"></a>

## Dank

Danke an alle Beteiligten (siehe diesen [Twitter Thread](https://twitter.com/acka47/status/1143820540785897472)), vor allem Jakob Voß und Carsten Klee für die schnelle Unterstützung. Das war ein zügige verbundübergreifende Zusammenarbeit, die Spaß gemacht hat.
Und merci im Vorabbereich an alle, die ihre offenen Schnittstellen im Sigelverzeichnis erfassen!

----

<sup>*</sup> Es gibt noch einige weitere Nutzungsarten des entsprechenden Feldes im Sigelverzeichnis, z.B. werden Links zur [Benutzungsordnung](https://lobid.org/organisations/search?q=availableChannel.serviceType%3ANutzung), zum [Standort](https://lobid.org/organisations/search?q=availableChannel.serviceType%3AStandort) oder zu den [Öffnungszeiten](https://lobid.org/organisations/search?q=availableChannel.serviceType%3A%C3%96ffnungszeiten) in dem Feld angegeben. Eine Liste der `serviceType`-Werte gibt es [hier](https://gist.github.com/acka47/bcf7d0cbbbb8de8d31220c12c2525171).
