
import strutils

type bag = tuple
    count : int
    color : string

type pline = tuple
    mainbag : bag
    contains : seq[bag]

proc parse_line(line : string) =
    let bd = split(line," bags contain")
    let leading_bag = (count:1,color:bd[0])
    echo("leading bag: ",leading_bag)
    let bags = split(bd[1],",")
    # echo("bags: ",bags)
    for b in bags:
        let bclear = strip(b)
        echo("\t***",bclear)
        if startsWith(bclear,"no other bags"):
            discard
            # who cares
        else:
            echo("\t\t",split(bclear," "))
            let bags_data = split(bclear," ")
            let b1 = (count: parseInt(bags_data[0]),color:bclear[1..len(bclear)-1].join(" "))
            echo("\t\t",b1)

proc part1(filename:string) =
    var inf = open(filename)
    defer : inf.close()

    var line : string
    while readline(inf,line):
        parse_line(line)

part1("test_input.txt")