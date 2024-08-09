Intro
=====

A software engineer with years of experiences on network devices.

The blog is intended to keep track of the learning progress
and review some knowledge learnt in the past.

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
