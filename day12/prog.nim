
import re
import strutils

type Ship = tuple
    facing : string
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
            if ship.facing=="E":
                ship.posx += step
            elif ship.facing=="W":
                ship.posx -= step
            elif ship.facing=="N":
                ship.posy -= step
            elif ship.facing=="S":
                ship.posy += step
        of "N","S","E","W":
            if dir=="N":
                ship.posy -= step
            elif dir == "S":
                ship.posy += step
            elif dir == "W":
                ship.posx -= step
            elif dir == "E":
                ship.posx += step
            else:
                echo "INVALID DIR"
        of "L","R":
            if dir == "R":
              # 180, 270, 90 ONLY
              if step == 90:
                if ship.facing == "E":
                  ship.facing = "S"
                elif ship.facing == "S":
                  ship.facing = "W"
                elif ship.facing == "W":
                  ship.facing = "N"
                elif ship.facing == "N":
                  ship.facing = "E"
              elif step == 180:
                if ship.facing == "E":
                  ship.facing ="W"
                elif ship.facing == "S":
                  ship.facing = "N"
                elif ship.facing == "W":
                  ship.facing = "E"
                elif ship.facing == "N":
                  ship.facing = "S"
              elif step == 270:
                if ship.facing == "E":
                  ship.facing = "N"
                elif ship.facing == "S":
                  ship.facing ="E"
                elif ship.facing == "W":
                  ship.facing = "S"
                elif ship.facing == "N":
                  ship.facing = "W"
            elif dir == "L":
              if step ==  90:
                if ship.facing == "E":
                  ship.facing = "S"
                elif ship.facing == "S":
                  ship.facing =  "W"
                elif ship.facing == "W":
                  ship.facing = "N"
                elif ship.facing == "N":
                  ship.facing = "E"
              elif step == 180:
                if ship.facing == "E":
                  ship.facing = "W"
                elif ship.facing == "S":
                  ship.facing = "N"
                elif ship.facing == "W":
                  ship.facing = "E"
                elif ship.facing == "N":
                  ship.facing = "S"
              elif step == 270:
                if ship.facing == "E":
                  ship.facing = "N"
                elif ship.facing == "S":
                  ship.facing = "E"
                elif ship.facing == "W":
                  ship.facing = "S"
                elif ship.facing == "N":
                  ship.facing = "W"
            else:
                echo "invalid facing"
        else:
            echo "invalid direction"    


proc test1() =
  var ship = (facing:"E",posx:0,posy:0)
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
  var ship = (facing:"E",posx:0,posy:0)
  for line in data:
    process(line,ship)

  echo "dist: ", abs(ship.posx) + abs(ship.posy)



part1()


