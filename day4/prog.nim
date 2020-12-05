
import strutils
import pd as pd

var person : int = 1

proc part1(filename:string) = 
    var inf = open(filename)
    defer: inf.close()

    var valid_count = 0

    var current : pd.PD
    pd.clear_PD(current)

    var line : string
    while readLine(inf,line):
        if line == "":
    
            echo("switching to new person",current)
            if check_valid_PD(current):
                valid_count+=1

            pd.clear_PD(current)
            person+=1

        else:
            let linedata = split(line)
            for index,thing in linedata:
                let thingdata = thing.split(":")
                pd.set_PD(thingdata,current)
                echo(person, " -- ",index," ",thing, " ", thingdata)

    echo("switching  to new person one last time",current)
    if pd.check_present_PD(current):
        valid_count += 1
    

    echo("valid count: ", valid_count)

proc part2(filename:string) = 
    var inf = open(filename)
    defer: inf.close()

    var valid_count = 0

    var current : PD
    pd.clear_PD(current)

    var line : string
    while readLine(inf,line):
        if line == "":
    
            echo("switching to new person",current)
            if pd.check_present_PD(current):
                if pd.check_valid_PD(current):
                    valid_count+=1
        
            pd.clear_PD(current)
            person+=1

        else:
            let linedata = split(line)
            for index,thing in linedata:
                let thingdata = thing.split(":")
                pd.set_PD(thingdata,current)
                echo(person, " -- ",index," ",thing, " ", thingdata)

    echo("switching  to new person one last time",current)
    if pd.check_present_PD(current):    
        if pd.check_valid_PD(current):
            valid_count+=1

    echo("valid count: ",valid_count)
# part1("test_input.txt")
# part1("input.txt")
# part2("input_invalid.txt")
part2("input.txt")