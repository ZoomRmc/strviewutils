from strutils import  Whitespace, Letters, Digits, HexDigits, IdentChars, IdentStartChars, NewLines, AllChars
{.experimental: "views".}
from strutils import nil
from math import pow

proc `$`*(s: openArray[char]): string =
  for x in s:
    result.add(x)

proc split*(s: openArray[char], sep: char , maxSplit = -1): seq[openArray[char]] =
  result = @[]
  var 
    i = 0
    lastMatch = 0
  while i < s.len:
    if s[i] == sep:
      result.add s.toOpenArray(lastMatch, i - 1)
      lastMatch = i + 1
      if maxSplit >= 0 and result.len == maxSplit:
        result.add s.toOpenArray(i, s.high)
        return
    inc i
  if lastMatch < s.len:
    result.add s.toOpenArray(lastMatch, s.high)

proc split*(s: openArray[char], seps: set[char] = Whitespace, maxSplit = -1): seq[openArray[char]] =
  result = @[]
  var 
    i = 0
    lastMatch = 0
  while i < s.len:
    if s[i] in seps:
      result.add s.toOpenArray(lastMatch, i - 1)
      lastMatch = i + 1
      if maxSplit >= 0 and result.len == maxSplit:
        result.add s.toOpenArray(i, s.high)
        return
    inc i
  if lastMatch < s.len:
    result.add s.toOpenArray(lastMatch, s.high)

proc split*(s: openArray[char], sep: openarray[char], maxSplit = -1): seq[openArray[char]] =
  result = @[]
  var 
    i = 0
    lastMatch = 0
  while i <= (s.len - sep.len):
    if s.toOpenArray(i, i + sep.high) == sep:
      result.add s.toOpenArray(lastMatch, i - 1)
      lastMatch = i + sep.len
      i += sep.high
      if maxSplit >= 0 and result.len == maxSplit:
        result.add s.toOpenArray(i + sep.len , s.high)
        return
    inc i
  if lastMatch < s.len:
    result.add s.toOpenArray(lastMatch, s.len - 1)

proc splitWhiteSpace*(s: openArray[char], maxSplit = -1): seq[openArray[char]] =
  s.split(Whitespace, maxSplit)

proc rSplit*(s: openArray[char], sep: char , maxSplit = -1): seq[openArray[char]] =
  result = @[]
  var 
    i = s.high
    lastMatch = s.high
  while i > 0:
    if s[i] == sep:
      result.add s.toOpenArray(i, lastMatch)
      lastMatch = i - 1
      if maxSplit >= 0 and result.len == maxSplit:
        result.add s.toOpenArray(0, lastMatch)
        return
    dec i
  if lastMatch > 0:
    result.add s.toOpenArray(0, lastMatch)

proc strip*(s: openArray[char], leading, trailing = true, chars = Whitespace): openArray[char] =
  var
    i = 0
    startPos = 0
    endPos = s.high
  if leading:
    while i < s.len:
      if s[i] notin chars:
        startPos = i
        break
      inc i
  if trailing:
    i = s.high
    while i >= 0:
      if s[i] notin chars:
        endPos = i
        break
      dec i
  result = s.toOpenArray(startPos,endPos)

proc integerOutOfRangeError() {.noinline.} =
  raise newException(ValueError, "Parsed integer outside of valid range")

proc parseInt*(s: openArray[char]): BiggestInt =
  var
    sign: BiggestInt = -1
    i, b: BiggestInt = 0
  if i < s.len:
    if s[i] == '+': inc(i)
    elif s[i] == '-':
      inc(i)
      sign = 1
  if i < s.len and s[i] in {'0'..'9'}:
    b = 0
    while i < s.len and s[i] in {'0'..'9'}:
      let c = ord(s[i]) - ord('0')
      if b >= (low(BiggestInt) + c) div 10:
        b = b * 10 - c
      else:
        integerOutOfRangeError()
      inc(i)
      while i < s.len and s[i] == '_': inc(i) # underscores are allowed and ignored
    if sign == -1 and b == low(BiggestInt):
      integerOutOfRangeError()
    else:
      result = b * sign

iterator reversed*(s: seq[openArray[char]]): openArray[char] =
  for i in countDown(s.high,0):
    yield s[i]
