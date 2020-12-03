
import tables as tables

type Position = tuple[row,col:int]

proc table_testing() =
    var t = tables.newTable[Position,bool]()
    proc crud(tr :TableRef) =
        t[(row:10,col:10)] = true
    var tt = initTable[Position,bool]()
    proc mud(t : var Table) =
        t[(row:1,col:1)]=true

    echo(tt)
    # crud(tt)
    mud(tt)
    echo(tt)

table_testing()