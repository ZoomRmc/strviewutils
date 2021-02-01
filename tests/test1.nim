import unittest
{.experimental: "views".}
import ../src/strviewutils
from strutils import nil

test "split":
  let data = "1321321,321321,53421"
  assert strutils.split(data, ',') == data.split(',')

test "multisplit":
  let data = "jkdsjal,dls.lp[]./,asd,"
  assert strutils.split(data, {'[','.','/'}) == data.split({'[','.','/'})

test "parseint":
  let 
    data = "1321321,321321,53421"
    split = strutils.split(data, ',')
  var i = 0
  for x in data.split(','):
    assert strutils.parseint(split[i]) == x.parseInt
    inc i

test "storing":
  let 
    data = "Hello world views"
    split = data.split(' ')
    hello: openArray[char] = split[0] 
    world: openArray[char] = split[1]
    views: openArray[char] = split[2]

  assert hello == "Hello"
  assert world == "world"
  assert views == "views"