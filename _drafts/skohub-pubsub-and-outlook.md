---
layout: post
title: "Presenting SkoHub PubSub 
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

In the previous blog posts we have presented [SkoHub Vocabs](http://blog.lobid.org/2019/09/27/presenting-skohub-vocabs.html) and [SkoHub Editor](http://blog.lobid.org/2020/03/31/skohub-editor.html). In the final post of this SkoHub introduction series we will present SkoHub PubSub, the part of SkoHub that brings the novel approach of "KOS-based content subscription" into the game.

Let's refresh what SkoHub is about by quoting the gist from [the project's homepage](https://skohub.io/):

> SkoHub supports a novel approach for finding content on the web. The general idea is to extend the scope of Knowledge Organization Systems (KOS) to also act as communication hubs for publishers and information seekers. In effect, SkoHub allows to follow specific subjects in order to be notified when new content about that subject is published. 

How could this approach be carried out in practice? Let's take a look at an example.

# Subscribing to a subject

Just take a look at a single subject from a controlled vocabulary published with SkoHub, e.g. [Library, information and archival studies](https://w3id.org/class/esc/n0322), and you can see the "Subscribe" button right under the concept URI:

<img src="/images/2019-09-18-skohub-prototype/subscribe.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:420px">

As the receiving end of notifications about new content about a specific subject SkoHub Deck makes use of the backend infrastructure provided by the [SkoHub Pubsub](https://github.com/hbz/skohub-pubsub) server. Although, SkoHub Pubsub is the core of the whole infrastructure and the module that connects all the other SkoHub components, it is not visible itself but only in applications like Mastodon and SkoHub Editor which can send out notifications to a specific topic.

So, when I descibe an OER with SkoHub Editor, assign the topic I have subscribed to and click "publish", a notification about the resource will be sent to the topic which will then disseminate the resource to every actor that has described to the topic.