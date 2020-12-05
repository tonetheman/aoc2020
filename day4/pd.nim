
import strutils as su
import re

type PD* = tuple
    byr : bool
    birth_year : int
    iyr : bool
    issue_year : int
    eyr : bool
    expiration_year : int
    hgt : bool
    hgt_value : int
    hgt_unit : string
    hcl : bool
    hcl_value : string
    ecl : bool
    ecl_value : string
    pid : bool
    pid_value : string
    cid : bool

proc clear_PD*(p : var PD) =
    p.byr = false
    p.birth_year = -1
    p.iyr = false
    p.issue_year = -1
    p.eyr = false
    p.expiration_year = -1
    p.hgt = false
    p.hgt_unit = ""
    p.hgt_value = -1
    p.hcl = false
    p.hcl_value = ""
    p.ecl = false
    p.ecl_value = ""
    p.pid = false
    p.pid_value = ""
    p.cid = false

proc set_PD*(thingdata: seq[string], p : var PD) =
    for index, thing in thingdata:
        if thing=="byr":
            p.birth_year = su.parseInt(thingdata[index+1])
            p.byr = true
        elif thing=="iyr":
            p.issue_year = su.parseInt(thingdata[index+1])
            p.iyr = true
        elif thing=="eyr":
            p.expiration_year = su.parseInt(thingdata[index+1])
            p.eyr = true
        elif thing=="hgt":
            var suff = thingdata[index+1]
            if suff.endsWith("cm"):
                p.hgt_unit = "cm"
                suff.removeSuffix("cm")
                p.hgt_value = parseInt(suff)
            elif suff.endsWith("in"):
                p.hgt_unit = "in"
                suff.removeSuffix("in")
                p.hgt_value = parseInt(suff)
            p.hgt = true
        elif thing == "hcl":
            p.hcl = true
            if match(thingdata[index+1], re"^#[a-f0-9]{6}$"):
                p.hcl_value = thingdata[index+1]
                # echo("HAIR COLOR SET ", p.hcl_value)
        elif thing == "ecl":
            if match(thingdata[index+1], re"amb|blu|brn|gry|grn|hzl|oth"):
                p.ecl_value = thingdata[index+1]
                # echo("EYE COLOR SET ",p.ecl_value)
            p.ecl = true
        elif thing=="pid":
            if match(thingdata[index+1],re"^[0-9]{9}$"):
                p.pid_value = thingdata[index+1]
                # echo("pid value is ",p.pid_value)
            p.pid = true
        elif thing == "cid":
            p.cid = true

proc check_present_PD*(p : PD ) : bool =
    # everything true this si valid
    if p.byr and p.iyr and p.eyr and p.hgt and p.hcl and p.ecl and p.pid and p.cid:
        echo("all fields true:PASS")
        return true

    # everything except cid is trur
    if p.byr and p.iyr and p.eyr and p.hgt and p.hcl and p.ecl and p.pid:
        echo("all fields except CID TRUE PASSED")
        return true

    return false

proc check_valid_PD*(p : PD) : bool = 
    if p.birth_year < 1920:
        return false
    if p.birth_year > 2002:
        return false
    if p.issue_year < 2010:
        return false
    if p.issue_year > 2020:
        return false
    if p.expiration_year < 2020:
        return false
    if p.expiration_year > 2030:
        return false
    if p.hgt_unit == "cm":
        if p.hgt_value < 150:
            return false
        if p.hgt_value > 193:
            return false
    elif p.hgt_unit == "in":
        if p.hgt_value < 59:
            return false
        if p.hgt_value > 76:
            return false
    else:
        return false
    if p.hcl_value == "": # regex checks this
        return false
    if p.ecl_value == "": # regex checks
        return false
    if p.pid_value == "": # regex checks
        return false

    return true