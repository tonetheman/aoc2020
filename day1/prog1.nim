

import strutils

proc prob1(filename : string) = 
    var inf : File
    inf = open(filename)
    var line : string
    var data = newSeq[int]()

    while readLine(inf,line):
        let val = parseInt(line)
        data.add(val)

    inf.close()

    echo(data)

    for i in 0..len(data)-1:
        let current = data[i]
        for j in 0..len(data)-1:
            let other = data[j]
            if i!=j:
                if current+other==2020:
                    echo("found it ",current, ": ",other," ",current*other)
                    return

# prob1("input.txt")
prob1("puzzle1input.txt")