

proc part1(filename:string) = 
    var inf = open(filename)
    defer: inf.close()


    var line : string
    while readLine(inf,line):
        if line == "":
            echo("blank")
        else:
            echo("not blank")





part1("test_input.txt")