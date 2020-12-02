
import strscans
import strutils as su

proc validate(lo,hi:int,val,passwd:string):bool =
    let count = su.count(passwd,val)
    if count >= lo and count <= hi:
        return true
    return false

proc prob1(filename : string) = 
    var inf : File
    inf = open(filename)
    defer: inf.close()
    var line : string
    var lo, hi : int
    var val : string
    var passwd : string
    var valid_count : int = 0
    while inf.readline(line):
        discard scanf(line,"$i-$i $w: $w",lo,hi,val,passwd)
        echo("low and hi: ",lo," ",hi," ",val," ",passwd)
        if validate(lo,hi,val,passwd):
            valid_count += 1
    echo("valid count is ",valid_count)

proc validate2(lo,hi:int,val,passwd:string):bool =
    var count : int = 0

    if passwd[lo-1]==val[0]:
        count+=1

    if passwd[hi-1]==val[0]:
        count+=1

    if count==1:
        return true

    return false

proc prob2(filename: string) =
    var inf : File
    inf = open(filename)
    defer: inf.close()
    var line : string
    var lo, hi : int
    var val : string
    var passwd : string
    var valid_count : int = 0
    while inf.readline(line):
        discard scanf(line,"$i-$i $w: $w",lo,hi,val,passwd)
        echo("low and hi: ",lo," ",hi," ",val," ",passwd)
        if validate2(lo,hi,val,passwd):
            valid_count += 1
    echo("valid count is ",valid_count)



# prob1("testinput.txt")
# prob1("input.txt")
# prob2("testinput.txt")
prob2("input.txt")