
import strutils
import tables
import re

const LEN = 36

proc readfile(filename:string) : seq[string] =
  let inf = open(filename)
  defer: inf.close()
  var line :string
  while readline(inf,line):
    result.add(line)

proc masker(index : int, val : int, mask : string, 
  memory : var Table[int,string]) = 

  let vs = toBin(val,LEN)
  # echo "vs:     ",vs
  # echo "mask:   ",mask
  var res = toBin(0,LEN)
  for index,c in vs:
    if mask[index]=='X':
      res[index] = c
    elif mask[index]=='0':
      res[index] = '0'
    elif mask[index]=='1':
      res[index] = '1'

    # echo "index: ",index, " c: ",c
  # echo "res: ",res
  memory[index] = res

proc test1() =
  var memory = initTable[int,string]()
  var mask :string = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
  masker(8, 11, mask, memory)
  masker(7,101,mask,memory)
  masker(8,0,mask,memory)

  echo memory
  echo fromBin[int](memory[7])
  echo fromBin[int](memory[8])

proc part1() = 
  # const filename = "test_input.txt"
  const filename = "input.txt"
  var data = readfile(filename)

  var memory = initTable[int,string]()
  var mask : string
  var md : array[2,string]
  var P = re(r"mem\[(\d+)\] = (\d+)")
  
  for line in data:
    let didmatch = match(line,P,md)
    let ldata = line.split()
    if ldata[0] == "mask":
      mask = ldata[2]
    elif ldata[0].startsWith("mem"):
      echo "mem line: ", md
      masker(parseInt(md[0]), parseInt(md[1]),mask,memory)

  var sum = 0
  for k,v in memory.pairs():
    sum += fromBin[int](v)
  
  echo "sum is: ",sum


part1()

