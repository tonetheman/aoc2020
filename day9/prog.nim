
import strutils

proc readfile(filename:string) : seq[int] =
    var inf = open(filename)
    var line : string
    while readline(inf,line):
        result.add(parseInt(line))

proc part1() =
    let filename = "test_input.txt"
    var data = readfile(filename)


    let PREAMBLE = 5

    let start_at = PREAMBLE-1
    let beg = 0

    var count = 0
    while true:

        let check_these = data[beg..beg+PREAMBLE-1]
        echo check_these
        for i in countup(len(check_these)):
            for j in countup(i,len(check_these)):
                echo(i, " ", j, " ", check_these[i], " ", check_these[j])


        count = count +  1
        if count>10:
            break


part1()