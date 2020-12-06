import tables

proc part1(filename:string) =
    var inf = open(filename)
    defer: inf.close()
    var line :string

    var gather = initTable[char,int]()
    gather.clear()

    var count = 0

    while readline(inf,line):
        # echo(line)
        for c in line:
            gather[c] = 1

        if line=="":
            # echo(len(gather))
            count += len(gather)
            # echo("new person")
            gather.clear()

    # echo(len(gather))
    # echo("last person")
    count += len(gather)
    echo("answer: ",count)

proc part2(filename:string) =
    var inf = open(filename)
    defer: inf.close()
    var line :string

    var gather = initTable[char,int]()
    gather.clear()

    var groupcount = 0
    var result = 0

    while readline(inf,line):
        # echo(line)

        # handle a group break
        if line == "":
            echo("total count in group: ",groupcount)
            echo(gather)
            echo()

            # just 1 person each question counts
            if groupcount==1:
                result += len(gather)
            else:
                # group is larger than 1 person
                # look for the number of elements with count>1
                for k,v in pairs(gather):
                    # echo("\tX: ",k," ",v)
                    if v>1:
                        result += 1
                        echo("adding 1 to result")

            gather.clear()
            groupcount = 0
            continue

        # handle a data line
        groupcount += 1
        for c in line:
            if gather.hasKey(c):
                gather[c]+=1
            else:
                gather[c] = 1 

    echo("total count in group: ",groupcount)
    echo(gather)
    echo()
    # just 1 person each question counts
    if groupcount==1:
        result += len(gather)
    else:
        # group is larger than 1 person
        # look for the number of elements with count>1
        for k,v in pairs(gather):
            # echo("\tX: ",k," ",v)
            if v>1:
                result += 1
                echo("adding 1 to result")




    echo("result ", result)



part2("test_input.txt")