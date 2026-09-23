---
layout: post
title: "Modernisierung des Technologie-Stacks der lobid-gnd-Benutzeroberfläche"
date: 2026-09-09
author: Adrian Pohl, Fabian Steeg
tags: lobid-gnd
---

lobid-gnd erleichtert die Arbeit mit der Gemeinsamen Normdatei (GND) auf verschiedene Weisen: Es stellt neben einer Rechercheoberfläche zum Durchsuchen der GND auch eine eine [Integration in OpenRefine](https://lobid.org/gnd/reconcile), sowie eine [Web-API](https://lobid.org/gnd/api) bereit. Die aktuelle lobid-gnd-Version ging im [Juni 2018](https://blog.lobid.org/2018/07/11/lobid-gnd-launch.html) in den Produktionsbetrieb nach langer Arbeit und auf Basis eines [Konzepts](https://blog.lobid.org/2017/06/08/lobid-api-why-how.html), das im Kern auf [Linked Open Usable Data (LOUD)](https://linked.art/loud/) mit JSON-LD setzt.[^loud]

Die Wahl des bis 2026 als Software-Lösung für die Umsetzung von lobid-gnd genutzten [Play Frameworks](https://en.wikipedia.org/wiki/Play_Framework) geht sogar zurück auf die vorherige Version der lobid-Dienste von 2013 ([Blogpost](https://service-wiki.hbz-nrw.de/x/RoGf)). Dreizehn Jahre sind viel im Software-Lebenszyklus und wir sahen uns zunehmend vor Herausforderungen gestellt, insbesondere im Hinblick auf die längerfristige Pflegbarkeit der Software: Das in Play u.A. als Template-Sprache genutzte Scala ist nicht sehr verbreitet, leidglich ein Team-Mitglied damit vertraut und es ist unrealistisch, perspektivisch Menschen zu finden, die damit arbeiten.

## Ein neuer Dienst als Auslöser

Mit der Migration des [Biographischen Portals NRW](https://de.wikipedia.org/wiki/Biographisches_Portal_NRW) von der Universitäts- und Landesbibliothek (ULB) Münster in das hbz müssen wir Verantwortung für einen neuen Dienst übernehmen, für den wir auf die bisherige Technologie gesetzt hätten. Konkret planten wir, das Biographische Portal – ähnlich wie die [Rheinland-Pfälzische Personendatenbank](https://rppd.lobid.org/) – als eine angepasste Version von [lobid-gnd](https://lobid.org/gnd) umsetzen und hätten damit ein weiteres System mit der bisherigen Technologie aufgesetzt, das dauerhaft gepflegt werden muss.

Daher haben wir uns vor etwa einem Jahr entschieden, das UI von lobid-gnd zuerst auf einen neuen Technologie-Stack umzuziehen, bevor wir weitere Anwendungen auf der Basis in Betrieb nehmen. Grundidee war dabei, auf verbreitete Technologien zu setzen. Speziell Play und Scala sind für Java-Entwickler:innen erstmal keine bekannten Technologien.

## Der neue Stack

Konkret war unser Ziel daher, das Gesamtframework von Play auf Spring Boot umzuziehen (das inzwischen Standard in der Java-Welt ist) und in den Templates die Verwendung von Scala abzuschaffen. Daher bietet sich Spring Boot mit der Standard-Template-Engine [Thymeleaf](https://www.thymeleaf.org/) an. Um die Vorteile des komplett asynchonen Play-Frameworks (non-blocking / event-driven / reactive) nicht zu verlieren, setzen wir auf Spring Boot mit [WebFlux](https://docs.spring.io/spring-framework/reference/web/webflux.html) / WebFlux.fn statt auf Spring MVC und Annotationen.

## Der Weg zur Umsetzung

Zur Umsetzung haben wir eine Art Integration-Test-Driven-Development verfolgt: Zunächst haben wir eine Testsuite für die vorhandene lobid-gnd-Implementierung geschrieben (s. [Issue](https://github.com/hbz/lobid-gnd-ui/issues/1)), deren Tests wir dann nach und nach auch für die neue Implementierung aktiviert haben.

So hatten wir einen Überblick über das, was getan werden muss und wie weit wir sind. Wir konnten dadurch auch sichergehen, dass die neue Implementierung nicht wesentlich abweicht, und hatten Leitplanken für die Entwicklung.

Die Umsetzung der Templates hat eine viel sauberere Trennung von HTML und Programmlogik und das Gradle-Build-Setup bietet neue Features für unsere Projektautomatisierung, z.B. automatische Anwendung von [Code-Formatter-Regeln](https://github.com/hbz/lobid-gnd-ui#run-checks). 

## Nur kleine UI-Änderungen und dunkler Modus

Die User Experience in lobid-gnd hat sich nicht geändert, es gibt lediglich kleinere Änderungen in der Benutzeroberfläche:
* Wir haben einige kleinere Ecken und Kanten im UI geglättet.
* Die Icons zu den Publikationstypen haben sich geändert, weil wir auf das Standard-Bootstraps-Iconset umgestiegen sind, um Abhängigkeiten zu minimieren.
* Die größte Änderung ist die Ergänzung eines dunklen Themes für alle Nutzer:innen, die – wie @rettinghaus, siehe das [Issue](https://github.com/hbz/lobid-gnd-ui/issues/15) – gerne in ihrem Web-Browser den Dark Mode nutzen:
![Das lobid-gnd-UI im dunklen Modus](/images/2026-09-09-lobid-gnd-dark-mode.png)

## Ausblick

Unser Plan ist, bei Neuentwicklungen, wie z.B. dem erwähnten Biographischen Portal, auf den neuen Technologie-Stack zu setzen, sowie die bestehenden Services unserer Gruppe nach und nach umzuziehen.

[^loud]: Auch wenn "LOUD" erst später geprägt wurde, nutzen wir den Begriff gerne, weil er unseren Ansatz sehr gut widerspiegelt.
