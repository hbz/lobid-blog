---
layout: post
title: "GND reconciliation for OpenRefine"
date: 2018-08-27
author: Fabian Steeg
tags: lobid-gnd
---

Our [lobid-gnd](https://lobid.org/gnd) service provides access to the Integrated Authority File [GND](https://en.wikipedia.org/wiki/Integrated_Authority_File). The service contains integration into [OpenRefine](http://openrefine.org/), a powerful tool for working with messy data. This tutorial provides an overview of GND reconciliation for OpenRefine. The features used here require OpenRefine 2.8 or later.

*Reconciliation* is the process of matching name strings to identifiers of entities in a database like an authority file, Wikidata etc. This is useful whenever you want to merge differing name strings for the same person in your data or when you want to fetch additional data from the target database you are reconciling against.

The first step in the reconciliation process is to create a project. OpenRefine can import data from various sources. For this tutorial, we'll simply import data from the clipboard:

![1](/images/2018-08-27-openrefine/01-input.png)

Copy these lines and paste them in OpenRefine:

```
name;beruf;ort
J. Weizenbaum;Informatiker;Berlin
Twain, Mark;Schriftsteller;
Kumar, Lalit;;
Jemand;;
```

![2](/images/2018-08-27-openrefine/02-data.png)

In the following preview screen you can take over the settings which were automatically detected and create the project:

![3](/images/2018-08-27-openrefine/03-create.png)

We now want to reconcile the text strings in the `name` column with GND entries:

![4](/images/2018-08-27-openrefine/04-reconcile.png)

We'll have to add the GND reconciliation service:

![5](/images/2018-08-27-openrefine/05-add-service.png)

Paste `https://lobid.org/gnd/reconcile` as the service URL:

![6](/images/2018-08-27-openrefine/06-service-url.png)

Collapse the drawer on the left hand side by clicking the newly added service. As our list for reconciliation consists solely of personal names, we now select `Person` to reconcile only against GND entries of type `Person`:

![7](/images/2018-08-27-openrefine/07-type.png)

For real-world data it can make sense to pass additional data from other columns to improve the reconciliation results (the value in the text box is arbitrary here, but must not be empty):

![8](/images/2018-08-27-openrefine/08-other.png)

After reconciliation, we can inspect not automatically matched candidates by clicking their name:

![9](/images/2018-08-27-openrefine/09-candidate.png)

This brings up a preview, with the option to match them:

![10](/images/2018-08-27-openrefine/10-preview.png)

After matching, we can enrich our data with the reconciled data. We want to add columns based on the reconciled values:

![11](/images/2018-08-27-openrefine/11-add-columns.png)

We can now select the properties we want to add and preview them. Here, we choose `Beruf oder Beschäftigung`, `Geburtsort`, `Sterbeort`, and `Ländercode`:

![12](/images/2018-08-27-openrefine/12-add-preview.png)

The first three properties are GND entries themselves, so they are recognized as reconciled items (they are links in the preview). 

For non-reconciled items that have a label and an ID in lobid-gnd (such as `Ländercode`), we can configure the content we want (label or ID) using the `configure` link for that property:

![13](/images/2018-08-27-openrefine/13-configure.png)

Note also the `limit` setting, which works for all properties and limits the number of values added for each entry (0 is the default, meaning no limit).

After confirming the preview (removing the old columns `beruf` and `ort`, cutting off the non-reconciled item using the facet on the left hand side), we have the enriched table with new data:

![14](/images/2018-08-27-openrefine/14-table.png)

We can now use the new reconciled items (like `Berlin` in the `Sterbeort` column here) to add more columns based on *their* properties (i.e. properties of `Berlin`, not `Weizenbaum, Joseph`):

![15](/images/2018-08-27-openrefine/15-extend.png)

As an example, we add a link to a depiction of the `Sterbeort`:

![16](/images/2018-08-27-openrefine/16-extend-preview.png)

Finally, we can export our data in various supported formats:

![17](/images/2018-08-27-openrefine/17-export.png)

This concludes our overview of GND reconciliation in OpenRefine. For further information check out the OpenRefine [general documentation](http://openrefine.org/documentation.html) and the [reconciliation wiki page](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation).