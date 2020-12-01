
import strutils

proc readints(filename:string) : seq[int] =
    var inf : File
    inf = open(filename)
    defer: inf.close()
    var line : string
    var data = newSeq[int]()

    while readLine(inf,line):
        let val = parseInt(line)
        data.add(val)
    return data

proc prob1(filename : string) = 
    let data = readints(filename)

    for index1,value1 in data:
        for index2,value2 in data:
            if index1!=index2:
                if value1+value2==2020:
                    echo(value1*value2)
                    return

proc prob2(filename:string) = 
    let data = readints(filename)

    for index1,value1 in data:
        for index2,value2 in data:
            if index1!=index2:
                for index3,value3 in data:
                    if index2!=index3:
                        if value1+value2+value3==2020:
                            echo(value1*value2*value3)
                            return

prob1("input.txt")
# prob1("puzzle1input.txt")

prob2("input.txt")
# prob2("puzzle1input.txt")
