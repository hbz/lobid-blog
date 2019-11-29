---
layout: post
title: "GND: Umstellung auf HTTPS-URIs"
date: 2019-11-29
author: Adrian Pohl
tags: lobid-gnd
---

Die Deutsche Nationalbiliothek (DNB) hat bereits im Oktober die URIs in verschiedenen Vokabularen und in der GND auf HTTPS umgestellt. Aus der [Ankündigung der DNB](https://www.dnb.de/SharedDocs/Downloads/DE/Professionell/Metadatendienste/Rundschreiben/rundschreiben20190703AenderungFormatRdf20193.pdf?__blob=publicationFile&v=3) (Hervorhebungen von mir):

> In allen Komponenten des Linked-Data-Services der ZDB und der DNB wird das Protokoll HTTP durch HTTPS ersetzt. Hintergründe zu dieser Entscheidung im [WIKI der DINI-AG Kompetenzzentrum Interoperable Metadaten](https://wiki.dnb.de/display/DINIAGKIM/HTTP+vs.+HTTPS+in+resource+identification).
>
> Betroffen sind im einzelnen:
> - DNB-Titel Profil „DINI-AG KIM-Empfehlungen“
> - ZDB-Titel Profil „DINI-AG KIM-Empfehlungen“
> - ISIL- und Sigelverzeichnis
> - **GND Profil „GND-Ontology“**
> - **Entity Facts**
> - **Alle RDF-Elementsets (GND-Ontology, DNB-Metadata-Terms, Agent
Relationship Ontology)**
> - **Alle RDF-Value-Vocabularies (GND-Geschlecht, GND-Ländercodes, GNDSystematik, GND-Koordinatentyp)**
>
> Ausgenommen ist vorerst nur der BIBFRAME-Prototyp, da er im nächsten Release grundlegend überarbeitet wird.

lobid-gnd basiert maßgeblich auf den von der DNB bereitgestellten RDF-Daten der GND. Deshalb werden auch in lobid die URIs auf HTTPS umgestellt. Uns ist bewusst, dass dies für lobid-basierte Anwendungen Probleme bereiten kann, weshalb wir Zeit für Anpassungen lassen. Unter [https://test.lobid.org/gnd](https://test.lobid.org/gnd) findet sich bereits die neue Version zum Testen (dort werden allerdings keine täglichen Updates eingespielt).

**Wir planen, die Umstellung am Donnerstag, den 12.12.2019 durchzuführen.**
