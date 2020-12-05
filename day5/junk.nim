
import tables

type Funk = object
    foo, goo : int

type Junk = tuple[foo,goo: int]

var t = initTable[int,int]()
var f = initTable[Funk,int]()
var g = initTable[Junk,int]()

#f[Funk(foo:10,goo:20)] = 10
g[(foo:10,goo:20)] = 100

t[10] = 20