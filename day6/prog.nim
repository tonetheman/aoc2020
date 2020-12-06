import tables

proc part1(filename:string) =
    var inf = open(filename)
    defer: inf.close()
    var line :string

    var gather = initTable[char,int]()
    gather.clear()

    var count = 0

    while readline(inf,line):
        for c in line:
            gather[c] = 1

        if line=="":
            count += len(gather)
            gather.clear()

    count += len(gather)
    echo("answer: ",count)

proc handle_break(gather: var Table[char,int], groupcount : var int,
    res : var int) =
    # just 1 person each question counts
    if groupcount==1:
        res += len(gather)
    else:
        # group is larger than 1 person
        # look for the number of elements with count>1
        for k,v in pairs(gather):
            if v>1:
                # THIS WAS MY DOWNDALL
                # the count needed to match the number
                # of people in the group
                # missed this in first version
                if groupcount == v:
                    res += 1

    gather.clear()
    groupcount = 0


proc part2(filename:string) =
    var inf = open(filename)
    defer: inf.close()
    var line :string

    var gather = initTable[char,int]()
    gather.clear()

    var groupcount = 0
    var result = 0
    var stopcount = 0

    while readline(inf,line):
        # handle a group break
        if line == "":
            handle_break(gather,groupcount,result)
            stopcount += 1
            continue

        # handle a data line
        groupcount += 1
        for c in line:
            if gather.hasKey(c):
                gather[c]+=1
            else:
                gather[c] = 1 

    # pickup the last group
    handle_break(gather,groupcount,result)


    echo("result ", result)



part2("input.txt")