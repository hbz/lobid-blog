---
layout: post
title: "Der SkoHub-Workflow zur Erstellung und Pflege kontrollierter Vokabulare"
date: 2019-07-30
author: Adrian Pohl
tags: skohub
---

Mittlerweile haben wir einige Fortschritte im SkoHub-Projekt (siehe [den letzten Blogbeitrag dazu](http://blog.lobid.org/2019/05/17/skohub.html)) gemacht. In diesem Blogbeitrag soll es vornehmlich um den Prozess und die Werkzeuge zur Erstellung, Pflege und Publikation von maschinenlesbaren kontrollierten Vokabularen gehen. Dafür wird zunächst kurz das Simple Knowledge Organization System (SKOS) für die Codierung kontrollierter Vokabulare vorgestellt. Als nächstes wird der redaktionelle Workflow für die Erstellung und Pflege eines SKOS-Vokabulars vorgestellt, der sich auf GitHub und einen im Projekt entwickelten Static Site Generator ([skohub-ssg](https://github.com/hbz/skohub-ssg)) stützt.

## SKOS: Publikation maschinenlesbarer kontrollierter Vokabulare im Web

Grob betrachtet sind alle Metadaten nach demselben Prinzip aufgebaut: `Feld: Feldinhalt`. Ein Beispiel:

```
title: Guidance By Railway Tracks
creator: Civil Engineering RWTH Aachen University
url: https://www.youtube.com/watch?v=vkzgcJGdUnA
publicationDate: 26.10.2016
license: CC-BY
subject: Bauingenieurwesen, Eisenbahntechnik
```