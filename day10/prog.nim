
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

proc checkit(data : seq[int]) : bool = 
  var charging_outlet = 0
  var current = 0
  var counts  = initTable[int,int]()

  while true:

      if current == len(data):
          break

      # echo "current: ", current, " charging outlet: ", charging_outlet, "  data[current] = ", data[current]
      let diff = data[current]-charging_outlet
      if diff < 1:
        return false
      if diff > 3:
        return false
      if counts.hasKey(diff):
          counts[diff] += 1
      else:
          counts[diff] = 1
      
      current += 1
      charging_outlet += diff

  # add the last diff of 3
  counts[3] += 1

  # echo counts, counts[3] * counts[1]    
  return true



proc part1() =
  # const filename = "test_input.txt"
  # const filename = "test_input2.txt"
  # const filename = "input.txt"
  var data = readfile(filename)
  data.sort()
  echo checkit(data)

proc part2() =
  # const filename = "test_input.txt"
  # const filename = "test_input2.txt"
  # const filename = "input.txt"
  var data = readfile(filename)
  data.sort()

  var resit = true
  var good = 0
  var bad = 0
  var count = 0

  while resit:

    if checkit(data):
      good += 1
    else:
      bad += 1

    resit = data.nextPermutation()
    if resit == false:
      break
  
    count += 1
    if count mod 100000 == 0:
      echo "count: ",count, "bad: ",bad, " good: ",good

  echo "good: ", good
  echo "Bad: ", bad

part2()

