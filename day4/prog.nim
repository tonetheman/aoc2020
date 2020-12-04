
import strutils
import re

var person : int = 1

type PD = tuple
    byr : bool
    birth_year : int
    iyr : bool
    issue_year : int
    eyr : bool
    expiration_year : int
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

proc set_PD(thingdata: seq[string], p : var PD) =
    # echo("set PD called ",p)
    for index, thing in thingdata:
        #  echo("\tcurrent thing : ", thing)
        if thing=="byr":
            # if match(thingdata[index+1],re"^(\d\d\d\d)$"):
            #    echo("BYR MATCH")
            p.birth_year = parseInt(thingdata[index+1])
            if p.birth_year >= 1920 and p.birth_year <= 2002:
                discard
            p.byr = true
        elif thing=="iyr":
            p.issue_year = parseInt(thingdata[index+1])
            if p.issue_year >= 2010 and p.issue_year <= 2020:
                discard
            p.iyr = true
        elif thing=="eyr":
            p.expiration_year = parseInt(thingdata[index+1])
            if p.expiration_year >= 2020 and p.expiration_year <= 3030:
                discard
            p.eyr = true
        elif thing=="hgt":
            p.hgt = true
        elif thing == "hcl":
            p.hcl = true
        elif thing == "ecl":
            p.ecl = true
        elif thing=="pid":
            p.pid = true
        elif thing == "cid":
            p.cid = true

proc check_valid(p : PD ) : bool =
    # everything true this si valid
    if p.byr and p.iyr and p.eyr and p.hgt and p.hcl and p.ecl and p.pid and p.cid:
        echo("all fields true:PASS")
        return true

    # everything except cid is trur
    if p.byr and p.iyr and p.eyr and p.hgt and p.hcl and p.ecl and p.pid:
        echo("all fields except CID TRUE PASSED")
        return true

    return false

proc part1(filename:string) = 
    var inf = open(filename)
    defer: inf.close()

    var valid_count = 0

    var current : PD
    clear_PD(current)

    var line : string
    while readLine(inf,line):
        if line == "":
    
            echo("switching to new person",current)
            if check_valid(current):
                valid_count+=1

            clear_PD(current)
            person+=1

        else:
            let linedata = split(line)
            for index,thing in linedata:
                let thingdata = thing.split(":")
                set_PD(thingdata,current)
                echo(person, " -- ",index," ",thing, " ", thingdata)

    echo("switching  to new person one last time",current)
    if check_valid(current):
        valid_count += 1
    

    echo("valid count: ", valid_count)

proc part2(filename:string) = 
    var inf = open(filename)
    defer: inf.close()

    var valid_count = 0

    var current : PD
    clear_PD(current)

    var line : string
    while readLine(inf,line):
        if line == "":
    
            echo("switching to new person",current)
            if check_valid(current):
                valid_count+=1

            clear_PD(current)
            person+=1

        else:
            let linedata = split(line)
            for index,thing in linedata:
                let thingdata = thing.split(":")
                set_PD(thingdata,current)
                echo(person, " -- ",index," ",thing, " ", thingdata)

    echo("switching  to new person one last time",current)
    if check_valid(current):
        valid_count += 1
    

    echo("valid count: ", valid_count)

# part1("test_input.txt")
# part1("input.txt")
part2("test_input.txt")