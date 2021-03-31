import unittest
import utils  

const UNESCAPED_V12 = "\n\r:\\"
const ESCAPED_V12 = "\\n\\r\\c\\\\"

const UNESCAPED_V11 = "\n:\\"
const ESCAPED_V11 = "\\n\\c\\\\"

test "can escape STOMP V1.2":
  check ESCAPED_V12 == utils.escapeV12(UNESCAPED_V12)

test "can unescape STOMP V1.2":
  check UNESCAPED_V12 == utils.unescapeV12(ESCAPED_V12)

test "can escape STOMP V1.1":
  check ESCAPED_V11 == utils.escapeV11(UNESCAPED_V11)

test "can unescape STOMP V1.1":
  check UNESCAPED_V11 == utils.unescapeV11(ESCAPED_V11)
