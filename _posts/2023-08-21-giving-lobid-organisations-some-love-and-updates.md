---
layout: post
title: "Giving lobid-organisations some love." Oder: Es war auch mal Zeit lobid-organisations upzudaten
date: 2023-08-21
author: Tobias Bülte & Adrian Pohl
tags: lobid-organisations
---
Manchmal funktionieren Dinge einfach vor sich hin, so auch lobid-organisations.
lobid-organisations ist ein umfassendes Verzeichnis von über 20.000 Gedächtnisinstitutionen (Bibliotheken, Archiven und Museen) im deutschsprachigen Raum.
Die Datenquellen dieses Dienstes sind das Deutsche ISIL-Verzeichnis und die Stammdaten der Deutschen Bibliotheksstatistik (DBS).
Darüber hinaus lassen sich auch die ZDB-E-Bookpakete suchen.

Es war der erste lobid Service, der in der aktuellen Version seit 2017 weitestgehend unverändert vor sich hin lief.

Wir konnten die Ruhe in der Sommerpause nutzen, um eine Modernisierung der Datentransformationsprozesse bei lobid-organisations durchzuführen.
Mit einem Update von Metafacture 4 auf die aktuelle Version und der Nutzung der Fix-Mappingsprache können gleichzeitig einige lang 
bestehende Probleme auf leichte Weise gelöst und viele Tickets geschlossen werden. 

Für einen Überblick siehe den Meilenstein unter https://github.com/hbz/lobid-organisations/milestone/1 . 

Die Veränderungen sind ohne uns bekannte API-Breaks.

Wir planen einen Wechsel auf dem produktiv System in 3 Wochen am 11.09.2023.
Bis dahin kann unter http://test.lobid.org/organisations, die aktuelle Version getestet werden.
