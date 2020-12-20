
import strutils

type Tile = object
    id : int
    data : seq[string]

proc readfile(filename:string) : seq[string] =
    let inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(line)

var tiles : seq[Tile]

let data = readfile("test_input.txt")
# let data = readfile("input.txt")

block build_ds:    
    var currentTile : Tile
    for line in data:
        if line.startsWith("Tile "):
            let line_data = line.split()
            currentTile.id = parseInt(line_data[1].split(":")[0])
            continue
        if line == "":
            echo("blank line: need to save tile now")
            tiles.add(currentTile)
            currentTile.id = 0
            currentTile.data.setLen(0)
            continue
        # must be a data line
        currentTile.data.add(line)

    tiles.add(currentTile)

echo(tiles)
echo(len(tiles))


# look for bottom match on tile0
echo("target",tiles[0].id,tiles[0].data[^1])
for i,t in tiles[1..^1]:
    echo(t.id, t.data[0])

