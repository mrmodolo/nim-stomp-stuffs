import re


let RE_ESCAPE_V12 = [
  ## Regular escape expression V1.2
  (re"\r", "\\r"),
  (re"\n", "\\n"),
  (re":", "\\c"),
  (re"\\", "\\\\")
  ]


let RE_UNESCAPE_V12 = [
  ## Regular unescape expression V1.2
  (re"\\r", "\r"),
  (re"\\n", "\n"),
  (re"\\c", ":"),
  (re"\\\\", "\\")
  ]


let RE_ESCAPE_V11 = [
  ## Regular escape expression V1.1
  (re"\n", "\\n"),
  (re":", "\\c"),
  (re"\\", "\\\\")
  ]


let RE_UNESCAPE_V11 = [
  ## Regular unescape expression V1.1
  (re"\\n", "\n"),
  (re"\\c", ":"),
  (re"\\\\", "\\")
  ]


proc escapeV12*(unescaped: string): string =
  ## Takes an unescaped string
  ## and escapes a string in version 1.2
  result = multiReplace(unescaped, RE_ESCAPE_V12)


proc unescapeV12*(escaped: string): string =
  ## Takes an escaped string
  ## and unescapes a string in version 1.2
  result = multiReplace(escaped, RE_UNESCAPE_V12)


proc escapeV11*(unescaped: string): string =
  ## Takes an unescaped string
  ## and escapes a string in version 1.1
  result = multiReplace(unescaped, RE_ESCAPE_V11)


proc unescapeV11*(escaped: string): string =
  ## Takes an escaped string
  ## and unescapes a string in version 1.1
  result = multiReplace(escaped, RE_UNESCAPE_V11)


proc escapeV10*(unescaped: string): string =
  ## Takes an unescaped string
  ## and escapes a string in version 1.0
  result = unescaped


proc unescapeV10*(escaped: string): string =
  ## Takes an escaped string
  ## and unescapes a string in version 1.0
  result = escaped
