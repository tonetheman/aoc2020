
import algorithm
import tables
import strutils


proc readfile(filename:string) : seq[int] = 
    var inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(parseInt(line))


var data = readfile("test_input.txt")
data.sort()

var charging_outlet = 0
var current = 0
var counts  = initTable[int,int]()

while true:

    if current == len(data):
        break

    echo "current: ", current, " charging outlet: ", charging_outlet, "  data[current] = ", data[current]
    let diff = data[current]-charging_outlet
    if counts.hasKey(diff):
        counts[diff] += 1
    else:
        counts[diff] = 1
    
    current += 1
    charging_outlet += diff

    

echo counts
    
