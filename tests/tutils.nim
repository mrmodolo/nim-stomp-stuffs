import unittest
import utils  

const UNESCAPED = "\n\r:\\"
const ESCAPED = "\\n\\r\\c\\\\"

test "can escape":
  check ESCAPED == utils.escapeV12(UNESCAPED)

test "can unescape":
  check UNESCAPED == utils.unescapeV12(ESCAPED)
