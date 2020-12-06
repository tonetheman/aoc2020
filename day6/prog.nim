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

part1("input.txt")