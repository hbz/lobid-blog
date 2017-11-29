---
layout: post
title: "Using the Java API for scripting in Elasticsearch 5.6"
date: 2017-11-29
author: Fabian Steeg
---

To create a custom aggregation [in lobid-resources for NWBib](https://github.com/hbz/lobid-resources/commit/72054407cd25371f58a28de0068a44ce8ada12bd), I used the Java API for scripting in Elasticsearch 5.6. It was surprisingly hard to find details on this, since there was no full, current documentation available. So here is the gist of it.

First, we specify the scripting language to use, and a script ID:

	String lang = "painless";
	String id = "topic-aggregation";

Then, our actual script content (as an example, we just pick the document's `type` field here):

	String script = "doc['type']";

Next, we have to create a JSON string to pass to the Elasticsearch API. Our goal is something like this:

	{ "script": { "lang": "painless", "source": "doc['type']" } }

To avoid escaping issues, we use a JSON lib here, like this:

	ObjectNode scriptObject = Json.newObject();
	scriptObject.putObject("script")
		.put("lang", lang).put("source", script);

We then wrap the JSON string into a `BytesArray` object:

	BytesArray bytes = new BytesArray(scriptObject.toString());

And finally use that object to store the script in our cluster:

	PutStoredScriptResponse response = client.admin().cluster()
		.preparePutStoredScript().setId(id)
		.setContent(bytes, XContentType.JSON).get();

Later, we can create a `Script` object based in the script ID:

	Script script = new Script(
		ScriptType.STORED, lang, id, Collections.emptyMap());

Which we can then use, e.g. in our `Aggregation`:

	searchRequest.addAggregation(
		AggregationBuilders.terms("topic").script(script));

For details on other Elasticsearch APIs and the [painless scripting language](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/modules-scripting-painless.html), see [the Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/index.html).