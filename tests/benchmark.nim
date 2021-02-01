import benchy
import random
from strutils import nil
from math import pow
{.experimental: "views".}
import ../src/strviewutils

let TempData = block:
  var 
    s = ""
    i = 0
  while i < 300000:
    let digits = rand(1..10)
    for i in 1..digits:
      s.add(rand('0'..'9'))
    s.add(' ')
    inc i
  s

timeit "Views Single Char Split", 1000:
  for x in TempData.split(' '):
    discard

timeit "Stdlib Single Char Split", 1000:
  for x in strutils.split(TempData, ' '): 
    discard

timeit "Views Multi Char Split", 1000:
  for x in TempData.split({' ','3'}):
    discard

timeit "Stdlib Multi Char Split", 1000:
  for x in strutils.split(TempData, {' ','3'}): 
    discard

var 
  viewI: seq[int]
  stdlibI: seq[int]

timeit "Views Int Parse", 1000:
  var hasAdded{.global.} = false
  for x in TempData.split(' '):
    if not hasAdded:
      try:
        viewI.add x.parseInt
      except: discard
  hasAdded = true
timeit "Stdlib Int Parse", 1000:
  var hasAdded{.global.} = false
  for x in strutils.split(TempData, ' '):
    if not hasAdded:
      try:
        stdlibI.add strutils.parseInt(x)
      except: discard
  hasAdded = true

assert stdlibI == viewI
var 
  view: seq[string]
  stdlib: seq[string]

timeit "View String Split", 1000:
  var hasAdded{.global.} = false
  for line in TempData.split("12"):
    if not hasAdded:
      view.add $line
  hasAdded = true

timeit "Stdlib String Split", 1000:
  var hasAdded{.global.} = false
  for line in strutils.split(TempData, "12"):
    if not hasAdded:
      stdlib.add line
  hasAdded = true
assert view == stdlib
