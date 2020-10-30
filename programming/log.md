# Logs

Logs provides details on what happened during the program.
It can help users and support engineers to check some information.
Further more, it can be analyzed by the AI program for special aims.
Besides that, it also helps engineers to debug issues.

Thus the well designed logs can improve the productivity.

## skills to check logs

With an existing log, the engineer shall find useful info from it.
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

A process may run several threads at the same time and
the thread id in the logs help us to ***exclude noises*** when
we track clues along one thread.

Every thing that can identity some "object" can be
taken as an "Id". For example, the "process name", the
***type*** of logs and even a special ***style*** of logs
can be taken as an id.