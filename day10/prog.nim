
import algorithm
import tables
import strutils


proc readfile(filename:string) : seq[int] = 
    var inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(parseInt(line))

# const filename = "test_input.txt"
# const filename = "test_input2.txt"
const filename = "input.txt"

var data = readfile(filename)
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

# add the last diff of 3
counts[3] += 1

echo counts, counts[3] * counts[1]    
