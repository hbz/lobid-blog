---
layout: post
title: "Customize your GND autosuggests"
date: 2024-06-24
author: Adrian Pohl
tags: lobid-gnd
---

Recently, the current lookup options in lobid-gnd turned out to not be enough for a use case we were facing. We needed to associate date and place of a person's birth/death but couldn't. So we added this option for everyone to benefit from. Now, you can get auto-suggests for GND persons that include a good overview of birth/death dates and places, occupations/professions and places of activity. They might for example look like this:

![Suggest list of different persons for query 'rowohlt' containing the named information with unicode icons fr birth and death](/images/20240624-custom-gnd-suggests/rpb-strapi-screenshot.png)

### How do I make lobid return a custom autosuggest format?

We have documented the configuration of such a customized GND autosuggest string in the [API documentation](https://lobid.org/gnd/api#auto-complete).

For example, here is the query that returns autosuggestions like the above: [`rowohlt+AND+type:Person&format=json:preferredName,*_dateOfBirth+_placeOfBirth,†_dateOfDeath+_placeOfDeath,placeOfActivity,professionOrOccupation`](https://lobid.org/gnd/search?q=rowohlt+AND+type:Person&format=json%3ApreferredName,*_dateOfBirth+_placeOfBirth,%E2%80%A0_dateOfDeath+_placeOfDeath,placeOfActivity,professionOrOccupation)

The reponse to this query looks like this:

```json
[ {
  "label" : "Rowohlt, Hilda | † 1943",
  "id" : "https://d-nb.info/gnd/116004595X",
  "category" : "Individualisierte Person"
}, {
  "label" : "Rowohlt, Charlotta | Schauspielerin",
  "id" : "https://d-nb.info/gnd/124750848X",
  "category" : "Individualisierte Person"
}, {
  "label" : "Rowohlt, Heinrich",
  "id" : "https://d-nb.info/gnd/139303960",
  "category" : "Individualisierte Person"
}, {
  "image" : "https://commons.wikimedia.org/wiki/Special:FilePath/HARRYROW.jpg?width=100",
  "label" : "Rowohlt, Harry | * 1945  Hamburg | † 2015  Hamburg | Schriftsteller; Lyriker; Verleger; Journalist; Sprecher; Übersetzer",
  "id" : "https://d-nb.info/gnd/107828553",
  "category" : "Individualisierte Person"
}, {
  "label" : "Rowohlt, Hilde",
  "id" : "https://d-nb.info/gnd/116667230",
  "category" : "Individualisierte Person"
}, {
  "label" : "Rowohlt, Ernst | * 1887  Bremen | † 1960  Hamburg | Leipzig; Berlin | Verleger",
  "id" : "https://d-nb.info/gnd/118603493",
  "category" : "Individualisierte Person"
}, {
  "label" : "Pierenkämper-Rowohlt, Maria | * 1910 | † 2005 | Hamburg-Volksdorf | Schauspielerin",
  "id" : "https://d-nb.info/gnd/116184620",
  "category" : "Individualisierte Person"
}, {
  "label" : "Ledig-Rowohlt, Heinrich Maria | * 1908  Leipzig | † 1992  Delhi | Verleger",
  "id" : "https://d-nb.info/gnd/118570757",
  "category" : "Individualisierte Person"
}, {
  "label" : "Ledig-Rowohlt, Jane | † 1994 | Hamburg",
  "id" : "https://d-nb.info/gnd/116853166",
  "category" : "Individualisierte Person"
}, {
  "label" : "Pierenkämpfer, Maria | * [19XX] | Schauspielerin",
  "id" : "https://d-nb.info/gnd/1329213513",
  "category" : "Individualisierte Person"
} ]
```

Basically, as with autosuggest queries before, you have to configure the response payload by using the `format=json` parameter, add a trailing colon and then the configuration bit which in our case is `preferredName,*_dateOfBirth+_placeOfBirth,†_dateOfDeath+_placeOfDeath,placeOfActivity,professionOrOccupation`.

As usual, you have a comma-seperated list of all the field contents you want to be returned. The additional option is provided by allowing to use `_{field}` with the addition of custom characters like "†". I could also use "born in"/"died in" instead, like this: [`preferredName,born in_dateOfBirth,placeOfBirth,died in_dateOfDeath,placeOfDeath,placeOfActivity,professionOrOccupation`](https://lobid.org/gnd/search?q=rowohlt+AND+type:Person&format=json%3ApreferredName,born in_dateOfBirth,placeOfBirth,died in_dateOfDeath,placeOfDeath,placeOfActivity,professionOrOccupation)

We hope that others will also benefit from this option. Let us know if you like it.


*This feature was added in the context of a project where we are building a new editorial backend for the regional bibliography and person database of Rhineland-Palatinate ([RPB](https://rpb.lbz-rlp.de/) &amp; [RPPD](https://rppd.lobid.org)). For looking up GND IDs in the [Strapi](https://strapi.io/)-based editorial backend, we are relying on the lobid-gnd API. We were happy to play back the needed improvements for the lookups into the lobid-gnd service.*