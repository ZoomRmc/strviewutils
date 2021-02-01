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

proc parseInt*(s: openArray[char]): int =
  var 
    i = 0
    place = s.high
  while i < s.len:
    let val = 
      case s[i]:
      of '0': 0
      of '1': 1
      of '2': 2
      of '3': 3
      of '4': 4
      of '5': 5
      of '6': 6
      of '7': 7
      of '8': 8
      of '9': 9
      of ' ', ',', '.', '_':
        dec place
        0
      else:
        raise newException(ValueError, "Non Digit Detected")
    result += val * 10f32.pow(place.float).int
    dec place
    inc i

iterator reversed*(s: seq[openArray[char]]): openArray[char] =
  for i in countDown(s.high,0):
    yield s[i]
