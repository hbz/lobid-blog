---
layout: post
title: "The class hierarchy of the Integrated Authority file GND (Gemeinsame Normdatei)"
date: 2018-03-20
author: Adrian Pohl
---

We started doing some work on the lobid-gnd service which currently is in beta: [https://lobid.org/gnd](https://lobid.org/gnd). Currently we are working on the type filter (see [issue #42](https://github.com/hbz/lobid-gnd/issues/42). As lots of sub-classes have been added to the GND ontology, it seemed like a good opportunity for a quick update of an old post from 2013 titled ["The GND ontology's class hierarchy - an overview"](https://wiki1.hbz-nrw.de/x/CIeW).

Still, the most general class in the GND ontology is "AuthorityResource". These are the classes on the lower levels:

- ConferenceOrEvent
   - SeriesOfConferenceOrEvent
- CorporateBody
   - Company
   - FictiveCorporateBody
   - MusicalCorporateBody
   - OrganOfCorporateBody
   - ProjectOrProgram
   - ReligiousAdministrativeUnit       
   - ReligiousCorporateBody
- Family
- Person
   - DifferentiatedPerson
      - CollectivePseudonym
      - Gods
      - LiteraryOrLegendaryCharacter
      - RoyalOrMemberOfARoyalHouse
      - Spirits
   - UndifferentiatedPerson
- PlaceOrGeographicName
   - AdministrativeUnit
   - BuildingOrMemorial
   - Country
   - ExtraterrestrialTerritory
   - FictivePlace
   - MemberState
   - NameOfSmallGeographicUnitLyingWithinAnotherGeographicUnit
   - NaturalGeographicUnit
   - ReligiousTerritory
   - TerritorialCorporateBodyOrAdministrativeUnit
   - WayBorderOrLine
- SubjectHeading
   - CharactersOrMorphemes
   - EthnographicName
   - FictiveTerm
   - GroupOfPersons
   - HistoricSingleEventOrEra
   - Language
   - MeansOfTransportWithIndividualName
   - NomenclatureInBiologyOrChemistry
   - ProductNameOrBrandName
   - SoftwareProduct
   - SubjectHeadingSensoStricto
- Work
   - Collection
   - CollectiveManuscript
   - Expression
   - Manuscript
   - MusicalWork
   - ProvenanceCharacteristic
   - VersionOfAMusicalWork