
import strutils

proc readfile(filename:string) : seq[int] =
    var inf = open(filename)
    var line : string
    while readline(inf,line):
        result.add(parseInt(line))

proc check(consider : seq[int], target : int ) : bool =
    for index, val in consider:
        for index2,val2 in consider:
            if index!=index2:
                if val+val2 == target:
                    echo "\t",val," ",val2," ",val+val2, " ", target
                    return true
    return false


proc part1() =
    let filename = "input.txt"
    var data = readfile(filename)

    # echo data

    let PREAMBLE = 25
    var starting_index = 0
    var current = PREAMBLE

    while true:

        if current>len(data):
            break


        let consider = data[starting_index..starting_index+PREAMBLE-1]
        
        echo "need to consider: ", consider, " ", data[current]

        if check(consider,data[current]):
            echo "FOUND A GOOD ONE"
        else:
            echo "FOUND A BAD ONE"
            break

        starting_index += 1
        current += 1
        


part1()
