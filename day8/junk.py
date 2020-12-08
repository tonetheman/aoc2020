

HALT_GOOD = "HALT_GOOD"
HALT_DEFAULT = "HALT_DEF"
HALT_VISITED = "HALT_VISITED"
HALT_UNK = "HALT_UNK"

def run_program(data):
    pc = 0
    acc = 0

    visited = {}

    while True:
        if pc==len(data):
            print("pc is equal to len data")
            return (HALT_GOOD,acc)

        if pc in visited:
            # print("halting for visit")
            return (HALT_VISITED,acc)
        else:
            visited[pc] = True

        # print("DBG: ",data[pc])
        tmp = data[pc].split()

        if tmp[0]=="nop":
            pc = pc + 1
        elif tmp[0]=="acc":
            acc = acc + int(tmp[1])
            pc = pc + 1
        elif tmp[0]=="jmp":
            pc = pc + int(tmp[1])
        else:
            print("ERR: unknown instruction")
            return (HALT_UNK,acc)


    return (HALT_DEFAULT,acc)


def part1():
    data = open("input.txt","r").readlines()
    (res,acc) = run_program(data)
    print(res,acc)

def part2():
    filename = "input.txt"
    data = open(filename,"r").readlines()
    count = len(data)

    for i in range(count):
        data = open(filename,"r").readlines()
        
        if data[i].startswith("nop"):
            tmp = data[i].split()
            data[i] = "jmp {0}".format(tmp[1])

            (res,acc) = run_program(data)
            print(res,acc,i)
        elif data[i].startswith("jmp"):
            tmp = data[i].split()
            data[i] = "nop {0}".format(tmp[1])
            (res,acc) = run_program(data)
            print(res,acc,i)

part2()