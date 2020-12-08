
import strutils
import tables

proc part1() =
    # let filename = "test_input.txt"
    let filename = "input.txt"
    var inf = open(filename)
    defer: inf.close()

    var data : seq[string] = @[]
    var line : string
    while readLine(inf,line):
        let idata = split(line)
        data.add(line)
    
    echo("all of the instructions")
    echo(data)

    # keep up with PC that have been visited
    var visited = initTable[int,bool]()

    var accumlator : int = 0
    var pc : int = 0
    var count = 0

    while true:
        let idata = split(data[pc])
        let operation = idata[0]
        let argument = idata[1]

        if visited.hasKey(pc):
            echo("HALT FOR VISITED, acc value is : ",accumlator)
            break

        visited[pc] = true

        if operation == "nop":
            echo("DBG: nop: current PC: ",pc," new pc: ",pc+1)
            pc = pc + 1
        elif operation == "acc":
            let old=accumlator
            accumlator +=  parseInt(argument)
            echo("DBG: acc: ", argument, " current PC: ",pc," new pc:",pc+1," ",old," ",accumlator)
            pc = pc + 1
        elif operation == "jmp":
            let old = pc
            pc = pc + parseInt(argument)
            echo("DBG: jmp ",argument,"old pc: ", old, " pc: ",pc)
        else:
            echo("UNKNOWN operation",operation," ",argument)
        
        if pc > len(data):
            echo("BROKE FOR ACCESS VIOLATION")
            break

        count = count + 1
        # if count>10:
        #     break


part1()