
import strutils
import tables

type program_res = tuple
    res : string
    acc : int

proc readfile(filename:string) : seq[string] =
    let inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(line)
    return

proc run_program(data : seq[string]) : program_res =
    var pc = 0
    var acc = 0
    var visited = initTable[int,bool]()

    while true:

        if pc==len(data):
            return ("HALT_GOOD",acc)

        if visited.hasKey(pc):
            return ("HALT_VIS",acc)
        else:
            visited[pc] = true

        let instruction = data[pc].split()
        if instruction[0]=="nop":
            pc+=1
        elif instruction[0]=="acc":
            acc += parseInt(instruction[1])
            pc+=1
        elif instruction[0]=="jmp":
            pc+=parseInt(instruction[1])
        else:
            return ("HALT_UNK",acc)
    return ("HALT_DEFAULT",acc)


proc part1() =
    let data = readfile("test_input.txt")
    echo run_program(data)

proc part2() =
    let filename = "input.txt"
    let data = readfile(filename)
    let count = len(data)

    for i in countup(0,count-1):
        var data = readfile(filename)
        if data[i].startsWith("nop"):
            let tmp = data[i].split()
            data[i] = "jmp " & tmp[1]
            echo run_program(data)
        elif data[i].startsWith("jmp"):
            let tmp = data[i].split()
            data[i] = "nop " & tmp[1]
            echo run_program(data)


part2()