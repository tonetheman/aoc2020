



proc part1(filename:string) =
    var inf : File
    inf = open(filename)
    defer: inf.close()

    var line : string
    while inf.readLine(line):
        echo(line)






part1("input.txt")
