

import strutils

var inf : File
inf = open("input.txt")
var line : string
var data = newSeq[int]()

while readLine(inf,line):
    let val = parseInt(line)
    data.add(val)

inf.close()

echo(data)