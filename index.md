Intro
=====

HELLO, this is Hz from the 21st century. Glad to meet you.

I am a software engineer with years of experiences on network devices.
And the blog intends to keep track of IT technology in my era.

When you read this text, you may find it is quite different
from that in your period. If this is the case,
you can take it as a historical document to study.

[#Network Protocols](./protocols.md)
--------------------

[#Aritificial Intelligence](./ai.md)
---------------------------

[#Blockchain](./blockchain/blockchain.md)
-------------

[#Programming](./programming/programming.md)
--------------

[#Reading Notes](./notes/note.md)
----------------

Cases
-----

[Goblog][goblog]
--------

A blog system used for recording ideas and analyzing
these articles via AI algorithms.

                            +--------+
    WebUI        ---->      |        |  ---->  mysql
                            |        |
    pprof        ---->      | goblog |  ---->  redis
                            |        |
    Test Suite   ---->      |        |  ---->  data center (AI analysis)
                            +--------+

Techniques:

* datastore: mysql &amp; redis
* blog frontend: html/css/javascript/w3.css framework
* blog backend: http server via golang
* restful api: for any http client that contains access tokens, e.g., curl/testscript/...
* data center: AI analysis server via python, NLP algrithms via pytorch
* container: they can run in respective docker containers

[goblog]: https://github.com/hzget/goblog
