
import strutils

proc part1() =
    var inf = open("test_input.txt")
    defer: inf.close()


    var accumlator : int = 0

    var line : string
    while readLine(inf,line):
        let idata = split(line)
        let operation = idata[0]
        let argument = idata[1]

        echo operation,argument
        if operation == "nop":
            discard
        elif operation == "acc":
            discard
        elif operation == "jmp":
            discard
        else:
            echo("UNKNOWN operation",operation," ",argument)

part1()