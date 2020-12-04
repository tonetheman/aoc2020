
import strutils
var person : int = 1

type PD = tuple
    byr : bool
    iyr : bool
    eyr : bool
    hgt : bool
    hcl : bool
    ecl : bool
    pid : bool
    cid : bool

proc clear_PD(p : var PD) =
    p.byr = false
    p.iyr = false
    p.eyr = false
    p.hgt = false
    p.hcl = false
    p.ecl = false
    p.pid = false
    p.cid = false

proc part1(filename:string) = 
    var inf = open(filename)
    defer: inf.close()

    var current : PD
    clear_PD(current)

    var line : string
    while readLine(inf,line):
        if line == "":
    
            echo("switching to new person",current)
            clear_PD(current)
            person+=1

        else:
            let linedata = split(line)
            for index,thing in linedata:
                let thingdata = thing.split(":")
                set_PD(thingdata,current)
                echo(person, " -- ",index," ",thing, " ", thingdata)





part1("test_input.txt")