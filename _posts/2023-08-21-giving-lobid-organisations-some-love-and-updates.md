---
layout: post
title: Pflege und Verbesserung von lobid-organisations 
date: 2023-08-21
author: Tobias Bülte & Adrian Pohl
tags: lobid-organisations
---

Manchmal funktionieren Dinge einfach vor sich hin, so auch lobid-organisations seit mehr als sechs Jahren.
lobid-organisations ist ein umfassendes Verzeichnis von über 20.000 Gedächtnisinstitutionen (Bibliotheken, Archiven und Museen) im deutschsprachigen Raum.
Die Datenquellen dieses Dienstes sind das Deutsche ISIL-Verzeichnis und die Stammdaten der Deutschen Bibliotheksstatistik (DBS).
Darüber hinaus lassen sich auch die ZDB-E-Bookpakete suchen.[^ebook]

lobid-organisations war der erste lobid-Dienst, den wir vor einigen Jahren modernisierten, um [2017 einen Relaunch zu verkünden](https://blog.lobid.org/2017/07/04/lobid-launch.html). Seitdem lief der Dienst weitestgehend unverändert vor sich hin. Über die Jahre sammelten sich allerdings eine Anzahl kleiner Tickets und es wurden Instandhaltungsarbeiten nötig.

So haben wir ein wenig Ruhe in der Sommerpause genutzt, um mit einer Modernisierung zu beginnen, indem wir zunächst die Datentransformationsprozesse auf einen aktuellen Stand bringen.
Mit einem Update von Metafacture 4 auf die aktuelle Version und der Nutzung der Fix-Mappingsprache können gleichzeitig einige lang 
bestehende Probleme auf leichte Weise gelöst und viele Tickets geschlossen werden. 

Für einen Überblick über die Tickets, die mit den Änderungen geschlossen werden, siehe den entsprechenden [Meilenstein](https://github.com/hbz/lobid-organisations/milestone/1). Wir wollen jegliche Probleme für bestehende API-Nutzer:innen vermeiden und haben versucht, nicht-rückwärtskompatible Änderungen auszuschließen.

Der neue Stand ist derzeit auf dem Testsystem deployt. Die Anpassungen sollen am am 18.09.2023 auf dem Produktivsystem aktiviert werden. Wir bitten Nutzer:innen der lobid-organisations-API, ihre Anwendungen probeweise gegen das Testsystem unter [https://test.lobid.org/organisations](https://test.lobid.org/organisations) laufen zu lassen und uns auf Probleme hinzuweisen, die wir eventuell übersehen haben.

Fußnote

[^ebook]: <small>Bei einer normalen Suche sind die E-Book-Pakete ausgeschlossen, weil es sich ja um ein Organisationsverzeichnis handelt. Sie können aber durch die Ergänzung einer Abfrage um `AND type:Collection` durchsucht werden, vgl. die Liste aller ca. 4000 E-Book-Pakete unter [https://lobid.org/organisations/search?q=\*+AND+type:Collection](https://lobid.org/organisations/search?q=*+AND+type:Collection).</small>