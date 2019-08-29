---
layout: post
title: "Der SkoHub-Workflow zur Erstellung und Pflege kontrollierter Vokabulare"
date: 2019-07-30
author: Adrian Pohl
tags: skohub
---

Mittlerweile haben wir einige Fortschritte im SkoHub-Projekt (siehe [den letzten Blogbeitrag dazu](http://blog.lobid.org/2019/05/17/skohub.html)) gemacht. In diesem Blogbeitrag soll es vornehmlich um den Prozess und die Werkzeuge zur Erstellung, Pflege und Publikation von maschinenlesbaren kontrollierten Vokabularen gehen. Dafür wird – nach einer kurzen Einführung zu Metadaten im allgemeinen – zunächst das Simple Knowledge Organization System (SKOS) für die Codierung kontrollierter Vokabulare vorgestellt. Als nächstes wird der redaktionelle Workflow für die Erstellung und Pflege eines SKOS-Vokabulars vorgestellt, der sich auf GitHub und einen im Projekt entwickelten Static Site Generator ([skohub-ssg](https://github.com/hbz/skohub-ssg)) stützt.

## Metadatenschemas und kontrollierte Vokabulare

Grob betrachtet sind alle Metadaten nach demselben Prinzip aufgebaut: `Feld: Feldinhalt`. Hier die Beschreibung einer Beispiel-Ressource:

```
title: Guidance By Railway Tracks
creator: Civil Engineering RWTH Aachen University
url: https://www.youtube.com/watch?v=vkzgcJGdUnA
thumbnail: https://i.ytimg.com/vi/vkzgcJGdUnA/hqdefault.jpg
publicationDate: 26.10.2016
license: CC-BY
subject: Bauingenieurwesen, Eisenbahntechnik
```

Dies ist eine für Menschen gut lesbare Beschreibung der Ressource. Will ich diese Art der Beschreibung konsistent innerhalb meines Systems oder systemübergreifend anwenden, kann ich ein *Metadatenschema* definieren: Dieses gibt vor, welche Felder es gibt, welche davon verpflichtend oder optional sind und welche Inhaltstypen sie haben sollen. Das könnte vereinfacht so aussehen:

```
mandatory:
	- title: string
	- creator: string
	- url: url

optional:
	- thumbnail: url
	- publicationDate: ISO8601
	- license: string
	- subject: string
```

Es gibt in dem Beispiel drei verschiedene Inhaltstypen (string, url, ISO8601), anhand derer Input validiert werden kann. Gibt z.B. jemand "März 2019" in das Feld `publicationDate` ein, so kann eine Fehlermeldung zurückgegeben werden. Im Feld subject sind nach diesem Schema jegliche Textstrings erlaubt, d.h. "Bauingenieurwesen" ist genauso erlaubt wie ein Wort mit Schreibfehler ("Bauingeneurwesen") oder auch ein anderes Wort, das sich auf dieselbe Sache bezieht ("Bautechnik").

Für einige der Feldinhalte eignet sich die Nutzung kontrollierter Vokabulare:

Vorteile:
-

## SKOS: Publikation maschinenlesbarer kontrollierter Vokabulare im Web