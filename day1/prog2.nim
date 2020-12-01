

import strutils

proc prob2(filename : string) = 
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
            if i!=j:
                let other = data[j]
                for k in 0..len(data)-1:
                    if j!=k:
                        let other2 = data[k]
                        if current + other + other2 == 2020:
                            echo("got it")
                            echo(current, " ", other, " ", other2)
                            echo(current*other*other2)
                            return

# prob1("input.txt")
prob2("puzzle1input.txt")