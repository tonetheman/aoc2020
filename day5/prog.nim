

type Seat = tuple
    row, col, id : int

proc find_seat(s : string) : Seat =
    var range_lo = 0
    var range_hi = 127
    var row = -1
    var col_lo = 0
    var col_hi = 7
    var col = -1
    echo("starting ",range_lo, range_hi)
        
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

            echo(index," ", c," ",range_lo, " " , range_hi)

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
        echo("final choice ", row, " ", col, " ", id)
        return
        
echo find_seat("FBFBBFFRLR")
echo find_seat("BFFFBBFRRR")