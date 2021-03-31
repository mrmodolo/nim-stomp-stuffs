import re


let RE_ESCAPE_V12 = [
  (re"\r", "\\r"),
  (re"\n", "\\n"),
  (re":", "\\c"),
  (re"\\", "\\\\")
  ]


let RE_UNESCAPE_V12 = [
  (re"\\r", "\r"),
  (re"\\n", "\n"),
  (re"\\c", ":"),
  (re"\\\\", "\\")
  ]


let RE_ESCAPE_V11 = [
  (re"\n", "\\n"),
  (re":", "\\c"),
  (re"\\", "\\\\")
  ]


let RE_UNESCAPE_V11 = [
  (re"\\n", "\n"),
  (re"\\c", ":"),
  (re"\\\\", "\\")
  ]


proc escapeV12*(unescaped: string): string =
  result = multiReplace(unescaped, RE_ESCAPE_V12)


proc unescapeV12*(escaped: string): string =
  result = multiReplace(escaped, RE_UNESCAPE_V12)


proc escapeV11*(unescaped: string): string =
  result = multiReplace(unescaped, RE_ESCAPE_V11)


proc unescapeV11*(escaped: string): string =
  result = multiReplace(escaped, RE_UNESCAPE_V11)


proc escapeV10*(unescaped: string): string =
  result = unescaped


proc unescapeV10*(escaped: string): string =
  result = escaped
