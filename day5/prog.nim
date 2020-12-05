
import tables, hashes

type Seat = object
    row, col, id : int

proc hash(s:Seat): Hash =
    result = s.row.hash !& s.col.hash !& s.id.hash

proc find_seat(s : string) : Seat =
    var range_lo = 0
    var range_hi = 127
    var row = -1
    var col_lo = 0
    var col_hi = 7
    var col = -1
    # echo("starting ",range_lo, range_hi)
        
    for index,c in s:
        if index<=6:
            # pick the row first
            let half = int((range_hi-range_lo)/2)

            if c == 'F':
                # take lower half
                range_hi = range_lo + half
            elif c == 'B':
                # take upper half
                range_lo = range_hi - half

            # echo(index," ", c," ",range_lo, " " , range_hi)

            if index == 6:
                # you are done
                # range lo and hi are the same
                row = range_lo
        else:
            # now pick the seat
            let half = int((col_hi-col_lo)/2)
            if c == 'L':
                # lower half
                col_hi = col_lo + half
            elif c == 'R':
                # upper half
                col_lo = col_hi - half
            # echo(index," col",col_lo, " ", col_hi)
            if index==9:
                col = col_lo

    let id = row * 8 + col
    result.row = row
    result.col = col
    result.id = id
    # echo("final choice ", row, " ", col, " ", id)
    return
        
proc testseat() =
    echo find_seat("FBFBBFFRLR")
    echo find_seat("BFFFBBFRRR")

proc part1(filename:string) =
    var inf = open(filename)
    defer: inf.close()

    var highest = -1
    var line : string
    while readline(inf,line):
        let res = find_seat(line)
        echo(res.id)
        if res.id>highest:
            highest = res.id

    echo("hi : ",highest)

proc part2(filename:string) =

    var inf = open(filename)
    defer: inf.close()

    var allseats : array[128, array[8, int] ]
    var line : string
    while readline(inf,line):
        let res = find_seat(line)
        allseats[ res.row ][ res.col ] = 1

    for index, s in allseats:
        echo(index, " ", s)

# part1("input.txt")
part2("input.txt")