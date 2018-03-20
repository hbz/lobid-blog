---
layout: post
title: "The GND class hierarchy, updated"
date: 2018-03-20
author: Adrian Pohl
---

We started doing some work on the lobid-gnd (in beta), the service providing access to the Integrated Authority File (GND): [https://lobid.org/gnd](https://lobid.org/gnd). Currently we are working on the type filter (see [issue #42](https://github.com/hbz/lobid-gnd/issues/42). As several of sub-classes have been added to the GND ontology in the meantime, it seemed like a good opportunity for a quick update of a post from 2013 titled ["The GND ontology's class hierarchy - an overview"](https://wiki1.hbz-nrw.de/x/CIeW).

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