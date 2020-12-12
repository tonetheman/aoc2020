
import re
import strutils

type Ship = tuple
    facing : int
    posx, posy : int

let P = re"(N|S|E|W|L|R|F)(\d+)"

proc process(s:string, ship : var Ship) =

    var matches : array[2,string]
    if find(s,P,matches)==0:
        echo matches
    else:
        echo "ERR: parse error, not found"

    var step = parseInt(matches[1])
    var dir = matches[0]

    case dir
        of "F":
          discard
        of "N","S","E","W":
          discard
        of "L","R":
            if dir == "R":
              ship.facing += step 
            elif dir == "L":
              ship.facing -= step
            else:
              echo "INVALID DIR FOR L/R"
            ship.facing = ship.facing mod 360
        else:
            echo "invalid direction"    


proc makeship() : Ship =
  result.facing = 0
  result.posx = 0
  result.posy = 0
  return

proc test1() =
  var ship = makeship()
  process("F10",ship)
  echo "ship: ",ship
  process("N3",ship)
  echo "ship: ",ship
  process("F7",ship)
  echo "ship",ship
  process("R90",ship)
  echo "ship",ship
  process("F11",ship)
  echo "ship",ship

  echo "dist: ", abs(ship.posx) + abs(ship.posy)


proc readfile(filename : string) : seq[string] =
  let inf = open(filename)
  defer: inf.close()
  var line : string
  while readline(inf,line):
    result.add(line)
  return

proc part1() =
  let data = readfile("input.txt")
  var ship = makeship()
  for line in data:
    process(line,ship)

  echo "dist: ", abs(ship.posx) + abs(ship.posy)

proc test0() =
  var ship = makeship()
  for i in 0..<4:
    process("L90",ship)
    echo ship


test0()
# test1()
# part1()


