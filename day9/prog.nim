
import strutils
import algorithm

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
        

proc part2() =
    # let target = 127
    let target = 20874512 #got from part1

    # let filename = "test_input.txt"
    let filename = "input.txt"
    var data = readfile(filename)

    # need to find contiguous group that sums to this number
    var group_size = 2
    while group_size<50:
        for index in countup(0,len(data)-group_size-1):
            var sumit = 0
            for j in countup(0,group_size):
                sumit += data[index+j]
            # echo "summit",sumit
            if sumit == target:
                echo "FOUND IT ",index," ", group_size
                echo data[index..index+group_size]

                var junk : seq[int]
                for tmp in data[index..index+group_size]:
                    junk.add(tmp)
                junk.sort()
                echo junk
                echo junk[0], " ", junk[^1]
                echo junk[0] + junk[^1]
                return
        group_size += 1

part2()
