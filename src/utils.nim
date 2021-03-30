import re

let RE_ESCAPE_V12 = [
  (re"\r", "\\r"),
  (re"\n", "\\n"),
  (re":", "\\c"),
  (re"\\", "\\\\")
  ]

let RE_UNESCAPE_V12* = [
  (re"\\r", "\r"),
  (re"\\n", "\n"),
  (re"\\c", ":"),
  (re"\\\\", "\\")
  ]


proc escapeV12*(unescaped: string): string =
  result = multiReplace(unescaped, RE_ESCAPE_V12)


proc unescapeV12*(escaped: string): string =
  result = multiReplace(escaped, RE_UNESCAPE_V12)
