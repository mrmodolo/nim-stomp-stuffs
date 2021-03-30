import
  strtabs, re

proc makeHeaderEscapes(): StringTableRef =
  result = {"\r": "\\r", "\n": "\\n", ":": "\\c",
      "\\": "\\\\"}.newStringTable

proc makeHeaderUnescapes(headerEscapes: StringTableRef): StringTableRef =
  result = newStringTable()
  for k, v in headerEscapes:
    result[v] = k


let
  HEADER_ESCAPES {.compileTime.} = makeHeaderEscapes()
  HEADER_UNESCAPES {.compileTime.} = makeHeaderUnescapes(HEADER_ESCAPES)
  HEADER_UNESCAPES_RE = [
    (re"\\r", "\r"),
    (re"\\n", "\n"),
    (re"\\c", ":"),
    (re"\\\\", "\\")
    ]
  HEADER_ESCAPES_RE = [
    (re"\r", "\\r"),
    (re"\n", "\\n"),
    (re":", "\\c"),
    (re"\\", "\\\\")
    ]


proc makeEncodedHeaders(): StringTableRef =
  result = {"content-length": "100",
            "content-type": "application/xml;charset=utf-8",
            "destination": "/queue/producer1\\c\\cqueue1",
            "receipt_01": "message_a\\nmessage_b\\n\\rmessage_c\\\\x62message_c",
            "receipt_02": "message_d\\nmessage_e\\n\\rmessage_f",
            "receipt_03": "message_g\\nmessage_h\\n\\rmessage_i",
            "client\\cteste": "message_j\\nmessage_k\\n\\rmessage_l"}.newStringTable


proc makeHeaders(): StringTableRef =
  result = {"content-length": "100",
            "content-type": "application/xml;charset=utf-8",
            "destination": "/queue/producer1::queue1",
            "receipt_01": "message_a\nmessage_b\n\rmessage_c\\x62message_c",
            "receipt_02": "message_d\nmessage_e\n\rmessage_f",
            "receipt_03": "message_g\nmessage_h\n\rmessage_i",
            "client:teste": "message_j\nmessage_k\n\rmessage_l"}.newStringTable


{.push used.}
proc unescapeHeader(match: string): string =
  let escaped = match
  if HEADER_UNESCAPES.hasKey(escaped):
    result = HEADER_UNESCAPES[escaped]
  else:
    result = escaped
{.pop.}


proc parseHeaders(headers: StringTableRef): StringTableRef =
  result = newStringTable()
  for k, v in headers.pairs:
    let key = multiReplace(k, HEADER_UNESCAPES_RE)
    if not result.hasKey(key):
      let value = multiReplace(v, HEADER_UNESCAPES_RE)
      result[key] = value


proc encodeHeaders(headers: StringTableRef): StringTableRef =
  result = newStringTable()
  for k, v in headers.pairs:
    let key = multiReplace(k, HEADER_ESCAPES_RE)
    if not result.hasKey(key):
      let value = multiReplace(v, HEADER_ESCAPES_RE)
      result[key] = value


proc testParseHeaders(): void =
  echo "Test parse headers!"
  let encodedHeaders = makeEncodedHeaders()
  let unencodedHeaders = parseHeaders(encodedHeaders)
  let headers = makeHeaders()
  for k, v in unencodedHeaders.pairs:
    assert headers.hasKey(k)
    assert headers[k] == v, headers[k] & " <> " & v


proc testHeaderEscapesAndUnescapes(): void =
  echo "Test HEADER_ESCAPES!"
  assert HEADER_ESCAPES["\r"] == "\\r"
  assert HEADER_ESCAPES["\n"] == "\\n"
  assert HEADER_ESCAPES[":"] == "\\c"
  assert HEADER_ESCAPES["\\"] == "\\\\"

  echo "Test HEADER_UNESCAPES!"
  assert HEADER_UNESCAPES["\\r"] == "\r"
  assert HEADER_UNESCAPES["\\n"] == "\n"
  assert HEADER_UNESCAPES["\\c"] == ":"
  assert HEADER_UNESCAPES["\\\\"] == "\\"

proc testOctet92(): void =
  let header = {"92": "\\x61\\x62\\x63"}.newStringTable
  let encodedHeader = encodeHeaders(header)
  echo "header: ", header, " encoded header: ", encodedHeader

proc main(): void =
  testHeaderEscapesAndUnescapes()
  testParseHeaders()
  testOctet92()

when isMainModule:
  main()

# vim:set nofoldenable:
