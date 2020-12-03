
import tables as tables

type Position = tuple[row,col:int]

proc loadfile(filename : string, right,down:int) : int = 
    var inf : File = open(filename)
    defer: inf.close()
    
    var data = initTable[Position,bool]()
    var current_row = 0
    var line : string
    var width, height : int

    while inf.readLine(line):
        # echo(line)
        width = len(line)
        for index,cc in line:
            # echo("\t",index,cc)
            if cc == '#':
                # adjust by the col amount passed in
                let p = ( row : current_row, 
                    col : index)
                data[p] = true

        current_row+=1
    height = current_row

    # do the work
    var count = 0
    var current_position  = (row: 0, col : 0)
    while true:
        # take a step
        current_position.row+=down
        current_position.col+=right

        let fakepos = (row:current_position.row,col:(current_position.col mod width) )
        if data.hasKey(fakepos):
            count += 1

        if current_position.row>height:
            break

    return count

# echo loadfile("test_input.txt",3,1)
echo loadfile("input.txt",1,1) * loadfile("input.txt",3,1) *
    loadfile("input.txt",5,1) * loadfile("input.txt",7,1) *
    loadfile("input.txt",1,2)