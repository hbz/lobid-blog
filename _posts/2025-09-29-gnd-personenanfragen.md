---
layout: post
title: "GND-Personendaten im Web: Zum Umgang mit Änderungsanfragen"
date: 2025-09-29
author: Adrian Pohl, Phu Tu, Ramona Schwind
tags: lobid-gnd
---

<div class="info-box">
    <span class="icon">ⓘ</span>
    <p>Für Rückmeldungen und Diskussion zu diesem Beitrag siehe den <a href="https://metadaten.community/t/gnd-personendaten-im-web-zum-umgang-mit-aenderungsanfragen/912">Crosspost im metadaten.community-Forum</a>.</p>
</div>

[lobid-gnd](https://lobid.org/gnd) ist – neben anderen wie dem [GND Explorer](https://explore.gnd.network/), [OGND](http://swb.bsz-bw.de/DB=2.104/), [Eurospider](http://gnd.eurospider.com) oder dem [DNB-Katalog](https://katalog.dnb.de) – ein Dienst, der die Daten der Gemeinsamen Normdatei (GND) zur Recherche im Web bereitstellt. lobid-gnd-Daten sind nicht in einer Datenbank versteckt und können somit durch Webcrawler wie dem [Googlebot](https://de.wikipedia.org/wiki/Googlebot) gecrawlt und in Websuchmaschinen indexiert werden. Wenn nun Menschen ihren Namen in einer Web-Suchmaschine eingeben, kann es leicht vorkommen, dass sie auf ihren GND-Personendatensatz in lobid-gnd stoßen.

Einige sind dann überrascht, dass und welche Daten über sie im Web bereitgestellt werden. Zudem erschließt sich ihnen wahrscheinlich der Kontext nicht, weil das Konzept bibliothekarischer Normdaten nicht allgemein bekannt ist. Einige dieser Menschen sehen Fehler in den Daten oder wollen Informationen wie das Geburtsjahr nicht veröffentlicht sehen. Sie suchen schließlich auf der lobid-gnd-Seite nach einer Kontaktmöglichkeit und wenden sich an uns, häufig mit Bitte um Löschung von Daten. Normalerweise sind das weniger als zehn Anfragen pro Jahr, im Januar und Mitte des Jahres 2025 haben wir allerdings innerhalb kurzer Zeit mehrere solcher Anfragen bekommen.

## Neu: Ein verständlicher Hinweis für lebende GND-Personen

Aufgrund der vermehrten und gehäuften Anfragen, haben wir uns endlich daran gemacht, einen verständlichen Hinweis auf den lobid-Seiten zu ergänzen (siehe [lobid-gnd#409](https://github.com/hbz/lobid-gnd/issues/409) für die detaillierte Umsetzung). Er wird bei allen Personeneinträgen angezeigt, die

1. ein Geburtsdatum haben, das nach 1940 liegt (Wir gehen davon aus, dass Menschen über 85 sich nicht mehr sonderlich für ihren GND-Eintrag interessieren)
2. **kein** Todesdatum haben.

Als Beispiel nehme wir mal Adrians GND-Eintrag: [https://lobid.org/gnd/14326723X](https://lobid.org/gnd/14326723X)

Wenn ich dort hinkomme, dann steht dort der folgende Hinweis:

![Screenshot von https://lobid.org/gnd/14326723X](/images/2025-09-29-gnd-personenanfragen/14326723X.png)

Unsere Hoffnung ist, dass Menschen, die über eine Internetsuchmaschine auf ihren GND-Eintrag kommen, diesen Hinweis sehen und anklicken. Nach dem Anklicken steht dort:

> ⓘ Diese Seite zeigt einen Datensatz aus der [Gemeinsamen Normdatei](https://de.wikipedia.org/wiki/Gemeinsame_Normdatei) (GND) an. Die GND wird von Bibliotheken, Archiven und Museen gepflegt und dient der eindeutigen Identifizierung von Urheber:innen. Ein GND-Eintrag zu einer Person wird beispielsweise bei der Katalogisierung einer Publikation angelegt, um die Publikation korrekt und eindeutig der Person zuordnen zu können.
> 
> Die Informationen in einem Normdatensatz werden ausschließlich aus öffentlich zugänglichen Quellen übernommen, Fehler oder Unvollständigkeiten sind nicht ausgeschlossen. Falls Sie Änderungen melden möchten oder mit der Veröffentlichung bestimmter Informationen nicht einverstanden sind, wenden Sie sich an gnd-datenschutz@hbz-nrw.de.

## Häufige Anfragen, viele Beteiligte, kein klarer Prozess

Die Notwendigkeit einer Hinweisbox haben wir gesehen, weil Anfragen bisher oft sehr umständlich bearbeitet wurden und wir einiges an Verbesserungspotenzial sahen. Im Folgenden erläutern wir diesen Hintergrund im Detail.

### Beispielanfragen mit einfacher Bitte um Anpassung/Löschung bestimmter Angaben

Hier sind zwei Beispielanfragen aus diesem Jahr (persönliche Daten wurden entfernt bzw. Namen geändert), die lediglich um Änderung/Löschung bitten ohne Verweis auf die DSGVO:

#### Bitte um Löschung eines gesamten Eintrags

> Sehr geehrte Damen und Herren,
> 
> bitte löschen Sie meinen Eintrag unter https://lobid.org/gnd/{id}. Über eine kurze Bestätigung würde ich mich sehr freuen.
> 
> Herzlichen Dank und beste Grüße!

#### Bitte um Löschung einer Verweisungsform

> Hallo zusammen,
> 
> ich weiß nicht ob ich mit der Verwendung dieses Email-Adressaten richtig
> liege.
> 
> Aber ich bin über lobit.org darauf gekommen, und denke, dass Sie meine
> Anfrage zumindest passend weiter leiten können.
> 
> 
> Gerade bin ich bei einer Google-Suche (man soll ja ab und zu mal schauen,
> was über einen so im Netz steht ;-) )
> 
> auf folgende Seite gestoßen
> 
> https://lobid.org/gnd/{id}
> 
> 
> und über den Eintrag:
> 
> "Varianter Name Schmidt-Müller, ...  "
> gestolpert.
> 
> 
> Also: Ich habe mich noch nie mit "Schmidt-Müller" bezeichnet, und auch andere
> haben das meines Wissens nicht (wie unter anderem eine dann darauf noch
> anschließende Google-Suche ergab).
> 
> Vermutlich kommt das von der gemeinsamen Autorenschaft unseres (Schmidt 
> Müller) Buchs "...".
> 
> Ich bin mit Herrn Müller aber weder verwandt noch verschwägert, noch sonst
> wie privat mit ihm besonders liiert – sodass es mich *schon* sehr wundert,
> wie so etwas überhaupt zustande gekommen ist.
> 
> Über eine Korrektur dieses Eintrags und gerne auch ein kurze Stellungnahme
> dazu würde ich mich freuen.

### Eine Beispielantwort

Eine Antwort unsererseits sieht beispielweise wie folgt aus:

> Liebe/r x,
> 
> vielen Dank für Ihre Mail zu Ihrem Eintrag unter https://lobid.org/gnd/id 
> 
> Es handelt sich bei dieser Seite um die Sicht des Normdatensatzes zu 
> Ihrer Person in der Gemeinsamen Normdatei (GND). Die GND unterstützt 
> die  Katalogisierung in Bibliotheken, Archiven und Museen und dient etwa 
> der Disambiguierung von Autor:innen. Ein GND-Eintrag zu einer Person 
> wird angelegt, wenn in einer Universitätsbibliothek eine Dissertation 
> oder eine andere Erstveröffentlichung einer Autorin erfasst wird.
> 
> Im Verbundkatalog der bayerischen Bibliotheken (https://www.gateway- 
> bayern.de/TP61/start.do) sind drei Ihrer Aufsätze erfasst.
> 
> Als der erste dieser Einträge angelegt wurde, wurde auch der 
> Normdatensatz angelegt. Die Informationen in einem Normdatensatz werden 
> immer ausschließlich aus öffentlich zugänglichen Quellen gespeist.
> 
> Dies zur Erläuterung des Kontextes. Wir denken im Prinzip, dass es 
> unrealistisch ist, dass der gesamte Datensatz gelöscht wird, weil er ja 
> eben mit verschiedenen Katalogtiteln verknüpft ist. Soweit ich weiß, 
> können die Kolleg:innen aber durchaus konkrete Informationen wie z.B. 
> das Geburtsdatum herausnehmen. Geben Sie uns gerne Bescheid, wie Sie 
> weiter vorgehen möchten oder wenn wir bei Fragen weiter behilflich sein können.

### Löschantrag nach DSGVO

In einem anderen Fall wurde explizit ein Löschantrag nach DSGVO formuliert[^gndsgvo]:

> Dear lobid support team,
> 
> I hope this email finds you well. My name is x, 
> and I am writing to request the removal of certain personal information 
> from the {id} record associated with my name. The information 
> includes:
> 
> 
>  1. Date of birth
>  2. Sex
>  3. Nationality 
> 
> I believe this data is not essential for the purposes for which it has 
> been processed and displayed. As such, I kindly request its removal in 
> accordance with my rights under *Article 17 of the General Data 
> Protection Regulation (GDPR)*. I value the important work your 
> organization does, but I also believe it is essential to protect my 
> personal privacy.
> 
> The specific record in question is:
> 
> \*Name:* x
> 
> \*Record Identifier: {id}
> 
> 
> I would appreciate it if you could confirm receipt of this email and let 
> me know if any additional information is required to process this 
> request. Please also inform me about the timeline for removing the 
> requested information.
> 
> 
> Thank you very much for your time and assistance. I look forward to your 
> response.

### Herausforderungen im Umgang mit Änderungsanfragen

Die Änderungswünsche kamen im hbz bisher per E-Mail an, aber an verschiedenen Orten: 

- beim lobid-Team, wenn die betroffenen Personen in der [Datenschutzerklärung](https://github.com/hbz/lobid/blob/master/conf/Datenschutzerklaerung_lobid.textile#85-widerspruchs--und-beseitigungsm%C3%B6glichkeit) nach einem Kontakt suchen
- bei der vom hbz-Marketing betreuten allgemeinen hbz-Info-E-Mail-Adresse (info-hbz@hbz-nrw.de), wenn im auf den lobid-Seiten verlinkten [hbz-Impressum](https://www.hbz-nrw.de/impressum) nachgeschaut wird.

An der Bearbeitung einer solchen Anfrage sind zudem mindestens zwei, teilweise drei oder sogar vier Parteien beteiligt. Auf jeden Fall involviert sind:

- Das **lobid-Team**, da es den Dienst betreibt, an den sich die Änderungsanfrage richtet.
- Die **GND-Redaktion** im hbz, die gewünschte Änderungen vornimmt.

Darüber hinaus können beteiligt sein:

- Das **hbz-Marketing**, weil es sich um die Anfragen an  info-hbz@hbz-nrw.de kümmert.
- Die **GND-Zentralredaktion** bei der Deutschen Nationalbibliothek (DNB), wenn – wie bei der obigen Anfrage nach DSGVO – in einem GND-Personensatz Daten gelöscht und der Datensatz für eine spätere Bearbeitung gesperrt werden muss.

Je mehr Parteien beteiligt sind und je unklarer ist, wer die Verantwortung trägt, wie der aktuelle Stand ist und was getan werden muss, desto zeitaufwändiger und langwieriger, je nach Rolle auch frustrierender kann die Kommunikation werden. Gerade bei DSGVO-Löschanträgen sind zeitliche Verzögerungen aber ggf. juristisch relevant, weshalb es wichtig ist, dass jemand Verantwortung übernimmt und sich darum kümmert, dass die nötigen Schritte umgesetzt werden.

### Ein kontrollierter, transparenter Prozess

Von der neu hinzugefügten Hinweisbox mit grundlegenden, allgemeinverständlichen Informationen zur GND und einem klaren Verweis auf eine Kontaktadresse bei Änderungswünschen versprechen wir uns:

1. Eine Person, die auf ihre GND-Personenseite kommt, kann schnell den Kontext des Datensatzes erfassen.
2. Ist die Person nach Erfassung des Kontexts mit der Darstellung bestimmter Informationen nicht einverstanden, hat sie eine klaren Kontaktpunkt (gnd-datenschutz@hbz-nrw.de) für Änderungsanfragen.
3. Wir im hbz haben dadurch die Möglichkeit, den Prozess zur Bearbeitung von GND-Änderungsanfragen besser zu steuern.

Was passiert nun, wenn jemand an gnd-datenschutz@hbz-nrw.de schreibt?

1. Es wird ein Ticket im hbz-internen [Zammad](https://zammad.org/)-System für Supportanfragen angelegt.
2. Die hbz-GND-Agentur sowie das lobid-Team werden über das Ticket benachrichtigt.
3. Die Kolleg:innen passen den entsprechenden Eintrag an und beauftragen ggf. die GND-Zentralredaktion der DNB zur Sperrung des Datensatzes (durch Vergabe des Katalogisierungslevels "z"[^z], das nur durch die GND-Zentralredaktion der DNB vergeben werden kann, siehe Seite 12f der [GND-Redaktionsanleitung](https://wiki.dnb.de/display/ILTIS/Informationsseite+zur+GND?preview=/90411323/94831126/Redaktionsanleitung.pdf)).
4. Das lobid-Team als verantwortliche Partei für die Webseite [https://lobid.org/gnd](https://lobid.org/gnd) kann prüfen, ob alle Daten wie gewünscht aktualisiert sind und entsprechende Löschungen im Testsystem nachziehen.
5. Ist alles erledigt, wird das Ticket geschlossen und wir haben gleichzeitig den Löschvorgang dokumentiert.
 
## GND-Löschanfragen und die GND-Kooperative

In den [FAQ](https://gnd.network/Webs/gnd/DE/UeberGND/FAQ/faq_node.html) auf gnd.network werden die DSGVO und Änderungswünsche behandelt, allerdings werden die kooperative Pflege in unterschiedlichen Institutionen und das dezentrale Anbieten der GND in unterschiedlichen Diensten nicht adressiert.

Wir waren bisher nicht beteiligt an einem Austausch über Änderungs- und Löschanträge (sei es mit oder ohne DSGVO-Verweis). Falls das Thema bereits anderswo diskutiert wurde, freuen wir uns über entsprechende Hinweise.

Womöglich kann dieser Beitrag ja anderen als Anstoß zum Austausch dienen oder hilfreich sein. Uns interessieren folgende Fragen:

- Wie gehen andere mit entsprechenden Anfragen um? 
- Im Kontext der Umsetzung fiel uns auf, dass es weder auf gnd.network noch im DNB-Wiki eine Erläuterung der GND für "Normalsterbliche" gibt, also für Menschen, die nicht regelmäßig mit Gedächtnisinstitutionen zu tun haben und mit dem Konzept "Normdaten" überhaupt noch nichts anfangen können (weshalb wir den Wikipedia-Eintrag verlinkt haben). Haben wir etwas übersehen? Falls das bisher echt fehlt, wäre so eine Infoseite für  Nicht-Bibliothekar:innen nicht sinnvoll?

---

[^gndsgvo]: Zum Thema GND und DSGVO siehe auch Lars Svenssons Blog-Beitrag ["Verantwortungsvoller Umgang mit sensiblen Daten bei zeitgenössischen Personen"](https://wiki.dnb.de/x/Gg7FEg).
[^z]: Momentan gibt es [944 GND-Einträge mit dem Katalogisierungslevel "z"](https://lobid.org/gnd/search?q=describedBy.descriptionLevel.id%3A%22https%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fdescription-level%23z%22&from=200&size=100&format=html), davon sind [775 Personeneinträge](https://lobid.org/gnd/search?q=describedBy.descriptionLevel.id%3A%22https%3A%2F%2Fd-nb.info%2Fstandards%2Fvocab%2Fgnd%2Fdescription-level%23z%22&filter=%2B%28type%3APerson%29).
