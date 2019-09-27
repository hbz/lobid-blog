# Subscribing to a subject

If you came this far into this post you may ask yourself: *But what about the "KOS-based content subscription" that SkoHub announced to implement?* Just take a look at a single subject from a controlled vocabulary published with SkoHub, e.g. [Library, information and archival studies](https://w3id.org/class/esc/n0322), and you can see the "Subscribe" button right under the concept URI:

<img src="/images/2019-09-18-skohub-prototype/subscribe.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:420px">

When you click this link, you will be driected to [SkoHub Deck](https://github.com/hbz/skohub-deck), an application to subscribe to and view notifications sent to a specific subject in your browser.

<img src="/images/2019-09-18-skohub-prototype/skohub-deck.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px">

As the receiving end of notifications about new content about a specific subject SkoHub Deck makes use of the backend infrastructure provided by the [SkoHub Pubsub](https://github.com/hbz/skohub-pubsub) server. Although, SkoHub Pubsub is the core of the whole infrastructure and the module that connects all the other SkoHub components, it is not visible itself but only in applications like SkoHub Deck and SkoHub Editor which can send out notifications to a specific topic.

So, when I descibe an OER in SkoHub Editor, assign the topic I have subscribed to and click "save", a notification about the resource will be sent to SkoHub Deck.

<img src="/images/2019-09-18-skohub-prototype/notification.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px">

With this prototype the basic functionality of SkoHub is presented as a proof of concept.
- an editor with validated structured data as output for
  1. *describing* a resource including the use of terms from a controlled vocabulary
  2. *sending notifications* to the terms' inboxes
- a process and application to *publish controlled vocabularies* represented in SKOS to the web and enable *lookup* of terms from the vocabulary
- the ability to *subscribe* to a vocabulary term and an application to view incoming messages about new resources

So the basic infrastructure is there but this is still a prototype. We will have to fix some smaller and bigger things and to generally improve the UI/UX of the components to make it production ready. We are happy to announce that we have obtained more funding for continuing SkoHub development and moving to production .

# To Dos for production

To achieve production level, we will directly continue work on SkoHub until the end of the year. Besides working on the UI/UX of the editor and static site generator, we have a lot of work to do on the PubSub backend (where we will switch the underlying pubsub protocol) and want to add some additional features. Here is a list of what we are thinking about.

- Move from WebSub to ActivityPub (see [#16](https://github.com/hbz/skohub-pubsub/issues/16) and the wiki page linked there)
- Enable easy setup on local server (Docker?)
- Offer plugins for content description and sending of notifications (e.g. for Moodle, WordPress and/or hypothes.is)
- Prototype for semi-automatic subject indexing in SkoHub Editor using [Annif](http://annif.org/)
- Provide more documentation
- Present SkoHub at conferences
- Create and maintain a reference application
- Find implementors
- Use SkoHub components in standardiziation work for OER metadata in the [DINI KIM](https://wiki.dnb.de/display/DINIAGKIM/OER-Metadaten-Gruppe) context (create agreed-upon schemas for describing OER and agree on controlled vocabularies for subjects, resource type etc.)

# Try it out

Please try it out. We are happy about bug reports, suggestions and feature requests for the production version. Get in contact with us via a hypothes.is annotation, GitHub, email, Twitter or IRC.