
import strutils
import re

type Bag = tuple
    count : int
    color : string

type BagContains = tuple
    mainbag : Bag
    contains : seq[Bag]

type Bag2 = tuple
    color : string
    contains : seq[string]

proc parse_single_line2(s:string) : Bag2 =
    let pass1 = s.split(" bags contain ")
    result.color = pass1[0]
    # var contains : seq[Bag]
    let pass2 = pass1[1].split(",")
    for v in pass2:
        var matches : array[3,string]
        let RE = re"\s*(\d+)\s+(\w+)\s+(\w+)"
        let res = match(v,RE,matches)   
        if res:
            for crud in countup(0,parseInt(matches[0])-1):     
                result.contains.add( matches[1..^1].join(" ") )
    

proc parse_single_line(s:string) :BagContains=
    let pass1 = s.split(" bags contain ")
    result.mainbag = (1,pass1[0])
    # var contains : seq[Bag]
    let pass2 = pass1[1].split(",")
    for v in pass2:
        var matches : array[3,string]
        let RE = re"\s*(\d+)\s+(\w+)\s+(\w+)"
        let res = match(v,RE,matches)   
        if res:     
            result.contains.add( (parseInt(matches[0]), matches[1..^1].join(" ")) )
    

proc readfile(filename:string) : seq[string] =
    let inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(line)

proc test() =
    let s = "light red bags contain 1 bright white bag, 2 muted yellow bags."

    echo parse_single_line(s)

proc test1() =
    let data = readfile("test_input.txt")
    for line in data:
        echo parse_single_line(line)


proc seqfind(check : Bag, answer:seq[Bag]) : bool =
    for b in answer:
        if b.color == check.color:
            return true
    return false

proc part1() =
    
    let filedata = readfile("input.txt")
    var bags : seq[BagContains]
    for line in filedata:
        bags.add(parse_single_line(line))

    let target = "shiny gold"

    var  answer :seq[Bag]
    
    for b in bags:
        for child in b.contains:
            if target == child.color:
                if not seqfind(b.mainbag,answer):
                    answer.add(b.mainbag)

    # now check the directs
    for j in countup(0,100): # THIS IS A CHEAT just brute forcing it
        for i in countup(0,len(answer)-1):
            let current_bag = answer[i]
            for b in bags:
                for child in b.contains:
                    if current_bag.color == child.color:
                        if not seqfind(b.mainbag,answer):
                            answer.add(b.mainbag)

    echo "ANSWER",answer,len(answer)

                            
proc part2() =
    let filedata = readfile("input2.txt")
    var bags : seq[Bag2]
    for line in filedata:
        bags.add(parse_single_line2(line))

    for b in bags:
        echo b

    var res : seq[string]
    res[0] = "shiny gold"

    for b in bags:
        if res[0]==b.color:
            discard
            # really need to substitute?



part2()
# part1()