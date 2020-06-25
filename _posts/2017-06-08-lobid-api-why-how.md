---
layout: post
title: "Lobid API 2.0: Why and how"
date: 2017-06-08
author: Fabian Steeg, Pascal Christoph
tags: lobid-resources lobid-organisations lobid-gnd
---

## Introduction: The Lobid API

[Lobid](http://lobid.org) provides uniform access to different library-related data via a web-based application programming interface (API) that serves JSON for linked data (JSON-LD):

![Data](/images/data.png "Data")

The idea is to decouple applications that make use of the data from specific data sources, formats, and systems. That way, these systems and formats can change, without requiring change in the applications, which use the data via the API. If you like, you can read more about why we think that [libraries need APIs](http://fsteeg.com/notes/why-lod-needs-applications-and-libraries-need-apis).

After the initial release of the API in 2013 we started [gathering improvements](https://github.com/hbz/lobid/issues/1) that would not be compatible with the released version, as a preparation for a future API 2.0 release. With the upcoming launch of our 2.0 APIs, we want to revisit these improvements, and describe how we implemented them.

## Architecture: from horizontal layers to vertical slices

The implementation of the 1.x system was a classical layered system: we had one repo that implemented the backend, which included data transformations and storage for all datasets, and one repo that implemented the API and frontend for all datasets. All datasets shared one Elasticsearch cluster, and all APIs and UIs ran in the same process.

In general, this resulted in things being entangled: if we wanted to switch to a newer Elasticsearch version that provided some feature required for one dataset, all others would have to move too. Or some software dependency needed for the API of one dataset would cause conflicts with dependencies that only the API of another dataset needed.

So for the 2.0 system, we sliced the system boundaries to [vertical, self contained systems](http://fsteeg.com/notes/more-self-containedness-less-code-sharing) for each data set:

![Architecture](/images/scs.png "Architecture")

Combining these modules, we still get a large API area, and a large UI, but each part of the API and UI is encapsuled in its own module, which deals with one dataset, and can be understood, changed, and deployed independently.

## JSON-LD: an RDF serialization, or JSON with context

JSON-LD is a W3C recommendation for a JSON-based linked data serialization. There are two ways to view JSON-LD: as an RDF serialization (like N-Triples, Turtle, or RDF-XML), or as a way to use JSON for linking data. This is reflected in the [JSON-LD spec](https://www.w3.org/TR/json-ld/), which both states that JSON-LD is "usable as RDF", and that it is "designed to be usable directly as JSON, with no knowledge of RDF". Regular JSON becomes serializable as RDF by [attaching a context](https://www.w3.org/TR/json-ld/#the-context).

### Generic JSON-LD in the 1.x system

For the 1.x API, we created N-Triples in our data transformation and automatically converted them to JSON-LD using a JSON-LD processor, thus treating it completely as an RDF serialization:

![Lobid 1](/images/lobid-1.png "Lobid 1")

The resulting JSON-LD used the URIs from the N-Triples as the JSON keys. We indexed this data in Elasticsearch as [expanded JSON-LD](https://www.w3.org/TR/json-ld/#expanded-document-form).<sup>1</sup> When serving responses via our API, we automatically converted the data to [compact JSON-LD](https://www.w3.org/TR/json-ld/#compacted-document-form) to get short, more user friendly keys. So we actually generated two formats: the internal index format, and the external API format.

### Custom JSON-LD in the 2.0 systems

#### Creating JSON-LD as JSON with context: lobid-organisations

For the first dataset that we moved to the new approach, lobid-organisations, we turned that around &mdash; instead of crafting N-Triples, and generating JSON-LD from them, we crafted JSON in the exact structure we want, from which we can then generate RDF serializations like N-Triples:

![Lobid 2](/images/lobid-2.png "Lobid 2")

The main advantage of this is that it puts the concrete use case first: we explicitly build our API, which our applications use, in the format that makes sense, instead of putting the abstraction first, from which we generate representations that are used by actual applications.

Compared to the approach in the 1.x API, this is at the opposite side of the spectrum described above, treating JSON-LD as JSON, with no knowledge of RDF.

#### Creating JSON-LD as an RDF serialization: lobid-resources

For lobid-resources 2.0, we adopted something in between. We decided to reuse and build upon the transformation script of API 1.x, as it already transforms our data into N-Triples. We then used code which was developed by Jan Schnasse for the [etikett project](https://github.com/hbz/etikett) to create custom JSON-LD from the N-Triples. Like for lobid-organisations, and unlike the lobid 1.x API, the resulting custom JSON-LD is the internal index format _and at the same time_ the external API format.

### Benefits of custom JSON-LD

Both approaches to creating custom JSON-LD, be it custom generated from N-Triples or 'hand crafted' JSON, yield multiple benefits.

#### What you see is what you can query

A central aspect is that we now serve the same format that is actually stored in the index. This allows us to support generic querying for any part of the data. For instance, if you look at a particular record, like [http://lobid.org/organisations/DE-605?format=json](http://lobid.org/organisations/DE-605?format=json), you see something like:

	"classification" : {
	  "id" : "http://purl.org/lobid/libtype#n96",
	  "type" : "Concept",
	  "label" : {
	    "de" : "Verbundsystem/ -kataloge",
	    "en" : "Union Catalogue"
	  }
	}

Based on the data you see, you can address any field, e.g. `classification.label.en` in a query like [http://lobid.org/organisations/search?q=classification.label.en:Union](http://lobid.org/organisations/search?q=classification.label.en:Union). With our old approach, where we stored expanded JSON-LD in our index, and served compact JSON-LD in our API, we had to support explicit query parameters for specific field queries &mdash; e.g. for titles, authors, or subjects &mdash; resulting in queries like:

`http://lobid.org/resource?name=Ehrenfeld`

These can now be expressed with a generic `q` query parameter and actual field names from the data:

`http://lobid.org/resources/search?q=title:Ehrenfeld`

This avoids a limitation of the supported query types to those we anticipated. It opens API access to the full data.

#### Semantically structured data

The generated JSON-LD in the 1.x API resulted in a flat structure, with objects in an array under the `@graph` key, e.g. in `http://lobid.org/organisation?id=DE-605&format=full`:

	"@graph": [
	    {
	        "@id": "http://purl.org/lobid/fundertype#n02",
	        "prefLabel": [{
	                "@language": "de",
	                "@value": "Land"
	            },{
	                "@language": "en",
	                "@value": "Federal State"
	        }]
	    },{
	        "@id": "http://purl.org/lobid/stocksize#n11",
	        "prefLabel": [{
	                "@language": "en",
	                "@value": "Institution without a collection"
	            },{
	                "@language": "de",
	                "@value": "Einrichtung ohne Bestand"
	        }]
	    }
	]

This structure was not very useful and seemed to go [against the pragmatic spirit of JSON-LD](http://fsteeg.com/notes/one-issue-with-json-ld-that-seems-not-so-pragmatic). If a developer is looking for the english funder type label, they would have to first iterate over all `@graph` elements, looking for the one with the fundertype `@id`, then iterate over alls its `prefLabel`s, looking for the one with the english `@language` field. In the new API, we provide the data in a structured, more JSON-like format:

	"fundertype": {
	    "id": "http://purl.org/lobid/fundertype#n02",
	    "type": "Concept",
	    "label": {
	        "de": "Land",
	        "en": "Federal State"
	    }
	
	},
	"collects": {
	    "type": "Collection",
	    "extent": {
	        "id": "http://purl.org/lobid/stocksize#n11",
	        "type": "Concept",
	        "label": {
	            "de": "Einrichtung ohne Bestand",
	            "en": "Institution without holdings"
	        }
	    }
	}

This allows developers familiar with JSON to process the data in a straightforward, familiar manner. The data is directly accessible, e.g. the english funder type label as `fundertype.label.en`.

Another example for adding semantics to our data by providing a custom structure in our JSON, and the effect of that data on its usage in the client, [are contributors and their roles in lobid-resources](http://blog.lobid.org/2016/12/13/data-modeling-client-effects.html).

#### Labels for IDs

When using the API, a common use case is to show labels for the URIs used to identify resources, authors, subjects, etc. For applications using the 1.x APIs, we implemented label lookup functionality in many different forms and contexts. To ease that use case, we provide labels in the 2.0 API along with IDs when it makes sense and is possible. For instance the old data would only contain a URI for the medium:

	"medium" : "http://rdvocab.info/termList/RDAproductionMethod/1010"

To display labels for URIs like this, we had to maintain mappings of URIs to labels in our client applications. In the new API, we provide the labels along with the URIs:<sup>2</sup>

	"medium": [{
	  "id": "http://rdaregistry.info/termList/RDAproductionMethod/1010",
	  "label": "Print"
	}]

Like for the creation of the JSON-LD in general, the implementation for adding these labels differs in the JSON-first and the Triples-first approach. In lobid-organisations, like all other aspects of the JSON creation, it is part of the transformation. For lobid-resources, a `labels.json` config file is used during the conversion from N-Triples to JSON-LD.

#### Summary: JSON-LD does not equal JSON-LD

A key take away from our experience with JSON-LD is that JSON-LD can be used and produced very differently. How it's created has major effects on how it can be processed, and on how useful it appears to developers with different backgrounds. While a pure RDF serialization as in our 1.x API might be perfectly usable for developers working on the RDF model anyway, it can alienate web developers familiar with JSON. This variety in what JSON-LD actually looks like provides a challenge in talking about the usefulness of JSON-LD. At the same time this is JSON-LD's unique strength, being both a JSON-based RDF serialization, and a simple way to link JSON data.

## User interfaces

In addition to these API and data changes, [Lobid](http://lobid.org) 2.0 provides improved user interfaces. While the original service only had rudimentary table views for single records and search queries, the new services provide full featured search interfaces including map based visualizations and faceted search.

----

<sup>1</sup> Elasticsearch expects consistent types for a specific field (e.g. the field `alternateName` should always be a string, or should always be an array), but compact JSON-LD uses a single string if there is only one value, or an array if there are multiple values. Expanded JSON-LD will always create an array, even if it contains a single value only. We would have needed something like compact keys with expanded values, but that is not available (see [https://github.com/json-ld/json-ld.org/issues/338](https://github.com/json-ld/json-ld.org/issues/338)).

<sup>2</sup> Note that the value is an array here, even though there's only one medium in this case. Since the data we serve is what we store in the index, we ensure that values are always arrays for fields that can have multiple values. See also footnote 1 above.
