
import strutils
import re

type Bag = tuple
    count : int
    color : string

type BagContains = tuple
    mainbag : Bag
    contains : seq[Bag]

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


proc part1() =
    
    let filedata = readfile("test_input.txt")
    var bags : seq[BagContains]
    for line in filedata:
        bags.add(parse_single_line(line))

    let target = "shiny gold"

    var  answer :seq[Bag]

    var direct_count = 0

    for b in bags:
        echo b
        for child in b.contains:
            if target == child.color:
                answer.add(b.mainbag)
    
    echo "ANSWER",answer


part1()