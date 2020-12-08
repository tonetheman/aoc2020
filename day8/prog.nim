
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


proc reload_instructions(filename:string) : seq[string] = 
    var inf = open(filename)
    defer: inf.close()

    var data : seq[string] = @[]
    var line : string
    while readLine(inf,line):
        let idata = split(line)
        data.add(line)

    return data

const HALT_NORMAL  = "HALT_NORMAL"
const HALT_VISITED = "HALT VISITED"
const HALT_ACCESS = "HALT_ACCESS"
const HALT_UNK = "HALT_UNK"

proc run_program(data:seq[string]) : string =
        # keep up with PC that have been visited
    var visited = initTable[int,bool]()

    var accumlator : int = 0
    var pc : int = 0
    var count = 0

    while true:
        
        var idata : seq[string]
        try:
            idata = split(data[pc])
        except:
            echo("DBG: accumulator is: ",accumlator)
            return "HALT_INVALID"

        let operation = idata[0]
        let argument = idata[1]

        if visited.hasKey(pc):
            echo("HALT FOR VISITED, acc value is : ",accumlator)
            return HALT_VISITED

        visited[pc] = true

        if operation == "nop":
            # echo("DBG: nop: current PC: ",pc," new pc: ",pc+1)
            pc = pc + 1
        elif operation == "acc":
            let old=accumlator
            accumlator +=  parseInt(argument)
            # echo("DBG: acc: ", argument, " current PC: ",pc," new pc:",pc+1," ",old," ",accumlator)
            pc = pc + 1
        elif operation == "jmp":
            let old = pc
            pc = pc + parseInt(argument)
            # echo("DBG: jmp ",argument,"old pc: ", old, " pc: ",pc)
        else:
            echo("UNKNOWN operation",operation," ",argument)
            return HALT_UNK
        
        if pc > len(data):
            echo("BROKE FOR ACCESS VIOLATION")
            return HALT_ACCESS
            break

        count = count + 1

    return HALT_NORMAL

proc part2(filename : string) = 
    
    # really lazy tony
    var data = reload_instructions(filename)
    let instruction_count = len(data)
    echo("total nunber of instructions in program: ",instruction_count)

    for i in countup(0,instruction_count-1):
        # reload a fresh copy of the instructions
        data = reload_instructions(filename)

        if data[i].startsWith("nop"):
            # get the full instruction and change to jmp
            let broke_instruction = data[i].split(" ")
            data[i] = "jmp " & broke_instruction[1]
            let res = run_program(data)
            echo("res from run program is ",res)
        elif data[i].startsWith("jmp"):
            # get full instruction and change to nop
            let broke_instruction = data[i].split(" ")
            data[i] = "nop " & broke_instruction[1]
            let res = run_program(data)
            echo("res from run program is ",res)
            
        else:
            # no one cares about this case
            discard


# part1()

part2("input.txt")