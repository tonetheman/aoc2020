


import tables as tables

type Position = tuple[row,col:int]

proc load_file_at_col(filename:string, 
    col : int,
    t : var Table, 
    width : var int, height : var int) =

    var inf : File
    inf = open(filename)
    defer: inf.close()

    # load the table up
    var current_row = 0
    var line : string
    while inf.readLine(line):
        # echo(line)
        width = len(line)
        for index,cc in line:
            # echo("\t",index,cc)
            if cc == '#':
                # adjust by the col amount passed in
                let p = ( row : current_row, 
                    col : index+col)
                t[p] = true

        current_row+=1
    height = current_row
    # finished loading table and info


proc part1(filename:string) =

    var data = initTable[Position,bool]()
    var width, height : int

    load_file_at_col(filename,0,data,
        width,height)

    var current_width = width

    # now do the work
    var count = 0
    var current_position  = (row: 0, col : 0)
    while true:
        # take a step
        current_position.row+=1
        current_position.col+=3

        if current_position.col > width:
            # echo("need to dup the data!!!",current_position)
            load_file_at_col(filename,current_width,data,
                width,height)
            current_width+=width

        # is there a tree?
        if data.hasKey(current_position):
            count += 1

        if current_position.row>height:
            break
        
    echo("count is ",count)


part1("input.txt")

