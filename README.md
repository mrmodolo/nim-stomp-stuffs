## STOMP Protocol Specification

[STOMP Protocol Specification, Version 1.2](https://stomp.github.io/stomp-specification-1.2.html)

[Value Encoding](https://stomp.github.io/stomp-specification-1.2.html#Value_Encoding)

The commands and headers are encoded in UTF-8. All frames except the CONNECT
and CONNECTED frames will also escape any carriage return, line feed or colon
found in the resulting UTF-8 encoded headers.

Escaping is needed to allow header keys and values to contain those frame
header delimiting octets as values. The CONNECT and CONNECTED frames do not
escape the carriage return, line feed or colon octets in order to remain
backward compatible with STOMP 1.0.

C style string literal escapes are used to encode any carriage return, line
feed or colon that are found within the UTF-8 encoded headers. When decoding
frame headers, the following transformations MUST be applied:

- \r (octet 92 and 114) translates to carriage return (octet 13)
- \n (octet 92 and 110) translates to line feed (octet 10)
- \c (octet 92 and 99) translates to : (octet 58)
- \\ (octet 92 and 92) translates to \ (octet 92)

Undefined escape sequences such as \t (octet 92 and 116) MUST be treated as a
fatal protocol error. Conversely when encoding frame headers, the reverse
transformation MUST be applied.

The STOMP 1.0 specification included many example frames with padding in the
headers and many servers and clients were implemented to trim or pad header
values. This causes problems if applications want to send headers that SHOULD
not get trimmed. In STOMP 1.2, clients and servers MUST never trim or pad
headers with spaces.

## stomp.py

[stomp.py](https://github.com/jasonrbriggs/stomp.py)

"stomp.py" is a Python client library for accessing messaging servers (such as
ActiveMQ, Artemis or RabbitMQ) using the STOMP protocol (STOMP v1.0, STOMP
v1.1 and STOMP v1.2). It can also be run as a standalone, command-line
client for testing. NOTE: Stomp.py has officially ended support for
Python2.x. See python3statement.org for more information.


