---
layout: post
title: "The GND class hierarchy, updated"
date: 2018-03-20
author: Adrian Pohl
tags: lobid-gnd
---

We started doing some work on the lobid-gnd (in beta), the service providing access to the Integrated Authority File (GND): [https://lobid.org/gnd](https://lobid.org/gnd). Currently we are working on the type filter (see [issue #42](https://github.com/hbz/lobid-gnd/issues/42)). As several of sub-classes have been added to the GND ontology in the meantime, it seemed like a good opportunity for a quick update of a post from 2013 titled ["The GND ontology's class hierarchy - an overview"](https://wiki1.hbz-nrw.de/x/CIeW).

Still, the most general class in the GND ontology is "AuthorityResource". These are the classes on the lower levels: \[**Update 2018-03-22**: *Now with the current number of entities with the respective type and with a link to those entities in lobid-gnd.*]

- [ConferenceOrEvent](http://lobid.org/gnd/search?filter=type:ConferenceOrEvent) (784,096)
   - [SeriesOfConferenceOrEvent](http://lobid.org/gnd/search?filter=type:SeriesOfConferenceOrEvent) (124,019)
- [CorporateBody](http://lobid.org/gnd/search?filter=type:CorporateBody) (1,494,345)
   - [Company](http://lobid.org/gnd/search?filter=type:Company) (0)
   - [FictiveCorporateBody](http://lobid.org/gnd/search?filter=type:FictiveCorporateBody) (17)
   - [MusicalCorporateBody](http://lobid.org/gnd/search?filter=type:MusicalCorporateBody) (0)
   - [OrganOfCorporateBody](http://lobid.org/gnd/search?filter=type:OrganOfCorporateBody) (110,665)
   - [ProjectOrProgram](http://lobid.org/gnd/search?filter=type:ProjectOrProgram) (1,450)
   - [ReligiousAdministrativeUnit](http://lobid.org/gnd/search?filter=type:ReligiousAdministrativeUnit) (0)
   - [ReligiousCorporateBody](http://lobid.org/gnd/search?filter=type:ReligiousCorporateBody) (0)
- [Family](http://lobid.org/gnd/search?filter=type:Family) (19,054)
- [Person](http://lobid.org/gnd/search?filter=type:Person) (11,047,320)
   - [DifferentiatedPerson](http://lobid.org/gnd/search?filter=type:DifferentiatedPerson) (4,310,992)
      - [CollectivePseudonym](http://lobid.org/gnd/search?filter=type:CollectivePseudonym) (532)
      - [Gods](http://lobid.org/gnd/search?filter=type:Gods) (553)
      - [LiteraryOrLegendaryCharacter](http://lobid.org/gnd/search?filter=type:LiteraryOrLegendaryCharacter) (1,325)
      - [RoyalOrMemberOfARoyalHouse](http://lobid.org/gnd/search?filter=type:RoyalOrMemberOfARoyalHouse) (2,979)
      - [Spirits](http://lobid.org/gnd/search?filter=type:Spirits) (103)
   - [UndifferentiatedPerson](http://lobid.org/gnd/search?filter=type:UndifferentiatedPerson) (6,736,328)
- [PlaceOrGeographicName](http://lobid.org/gnd/search?filter=type:PlaceOrGeographicName) (301,281)
   - [AdministrativeUnit](http://lobid.org/gnd/search?filter=type:AdministrativeUnit) (11,844)
   - [BuildingOrMemorial](http://lobid.org/gnd/search?filter=type:BuildingOrMemorial) (6,4735)
   - [Country](http://lobid.org/gnd/search?filter=type:Country) (327)
   - [ExtraterrestrialTerritory](http://lobid.org/gnd/search?filter=type:ExtraterrestrialTerritory) (261)
   - [FictivePlace](http://lobid.org/gnd/search?filter=type:FictivePlace) (30)
   - [MemberState](http://lobid.org/gnd/search?filter=type:MemberState) (579)
   - [NameOfSmallGeographicUnitLyingWithinAnotherGeographicUnit](http://lobid.org/gnd/search?filter=type:NameOfSmallGeographicUnitLyingWithinAnotherGeographicUnit) (1,877)
   - [NaturalGeographicUnit](http://lobid.org/gnd/search?filter=type:NaturalGeographicUnit) (17,749)
   - [ReligiousTerritory](http://lobid.org/gnd/search?filter=type:ReligiousTerritory) (2,833)
   - [TerritorialCorporateBodyOrAdministrativeUnit](http://lobid.org/gnd/search?filter=type:TerritorialCorporateBodyOrAdministrativeUnit) (185,237)
   - [WayBorderOrLine](http://lobid.org/gnd/search?filter=type:WayBorderOrLine) (4,613)
- [SubjectHeading](http://lobid.org/gnd/search?filter=type:SubjectHeading) (207,186)
   - [CharactersOrMorphemes](http://lobid.org/gnd/search?filter=type:CharactersOrMorphemes) (1,939)
   - [EthnographicName](http://lobid.org/gnd/search?filter=type:EthnographicName) (4,194)
   - [FictiveTerm](http://lobid.org/gnd/search?filter=type:FictiveTerm) (2)
   - [GroupOfPersons](http://lobid.org/gnd/search?filter=type:GroupOfPersons) (349)
   - [HistoricSingleEventOrEra](http://lobid.org/gnd/search?filter=type:HistoricSingleEventOrEra) (5,206)
   - [Language](http://lobid.org/gnd/search?filter=type:Language) (5740)
   - [MeansOfTransportWithIndividualName](http://lobid.org/gnd/search?filter=type:MeansOfTransportWithIndividualName) (1,377)
   - [NomenclatureInBiologyOrChemistry](http://lobid.org/gnd/search?filter=type:NomenclatureInBiologyOrChemistry) (30,721)
   - [ProductNameOrBrandName](http://lobid.org/gnd/search?filter=type:ProductNameOrBrandName) (5,602)
   - [SoftwareProduct](http://lobid.org/gnd/search?filter=type:SoftwareProduct) (8,026)
   - [SubjectHeadingSensoStricto](http://lobid.org/gnd/search?filter=type:SubjectHeadingSensoStricto) (135,680)
- [Work](http://lobid.org/gnd/search?filter=type:Work) (324,074)
   - [Collection](http://lobid.org/gnd/search?filter=type:Collection) (1,112)
   - [CollectiveManuscript](http://lobid.org/gnd/search?filter=type:CollectiveManuscript) (0)
   - [Expression](http://lobid.org/gnd/search?filter=type:Expression) (5,270)
   - [Manuscript](http://lobid.org/gnd/search?filter=type:Manuscript) (5,747)
   - [MusicalWork](http://lobid.org/gnd/search?filter=type:MusicalWork) (167,771)
   - [ProvenanceCharacteristic](http://lobid.org/gnd/search?filter=type:ProvenanceCharacteristic) (2,236)
   - [VersionOfAMusicalWork](http://lobid.org/gnd/search?filter=type:VersionOfAMusicalWork) (2,949)
