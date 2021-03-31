discard """
  action:    "run"
  targets:   "c"
  exitcode:  0
  nimout:    ""
  timeout:   60.0
"""

# cmd:       "nim --debugInfo --assertions:on --linedir:on --define:debug -o:build/tutils2 --nimcache:.cache c tests/tutils2.nim"

import utils  

const UNESCAPED_V12 = "\n\r:\\"
const ESCAPED_V12 = "\\n\\r\\c\\\\"

const UNESCAPED_V11 = "\n:\\"
const ESCAPED_V11 = "\\n\\c\\\\"

# "can escape STOMP V1.2"
block escapeV12:
  doAssert ESCAPED_V12 == utils.escapeV12(UNESCAPED_V12)

# "can unescape STOMP V1.2"
block unescapeV12:  
  doAssert UNESCAPED_V12 == utils.unescapeV12(ESCAPED_V12)

# "can escape STOMP V1.1"
block escapeV11:
  doAssert ESCAPED_V11 == utils.escapeV11(UNESCAPED_V11)

# "can unescape STOMP V1.1"
block unescapeV11:
  doAssert UNESCAPED_V11 == utils.unescapeV11(ESCAPED_V11)

