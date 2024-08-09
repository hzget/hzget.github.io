# Logs

Logs provides details on what happened during the run-time of a program.
It can help users and support engineers to check app status.
Further more, it can be analyzed by the AI program for special aims.
Besides that, it also helps engineers to debug issues.

## skills to debug issues via logs

With an existing log, the engineer may find useful info.
He shall examine the logs carefully just like a detective.
Truth floods in tons of logs. The detective shall be sharp and patient.
He shall be very experienced in finding "clues".

### timestamp

The timestamp of each logs give the ***Orders*** of related events.
There may be ***causual relationship*** between them.

***Time SPAN*** between adjacent logs may be abnormal:
too big or too small when compared with others. It gives
useful info: the thread may be blocked for some reason;
it may handle abnormal data; and so forth.
The engineer shall check the reason of this abnormal time span.

### id

A process may open parallel threads for the same task and
the thread id in the logs help us to ***exclude noises*** when
we track clues along one specific thread.

Every thing that can identity some "object" can be
taken as an "Id". For example, the "process name", the
***type*** of logs and even a special ***style*** of logs
can be taken as an id.

## design of logs

Well designed logs can improve the productivity.

### for debugging issues

To help "detectives" to find "clues", the logs shall give
the following info:

* timestamp of each piece of logs
* id
* info of special events

### for AI program

To help AI analysis, the log shall give info with
special patterns according to the AI requirement.
