

import strutils
import sequtils

proc readfile(filename : string) : seq[string] =
    let inf = open(filename)
    defer: inf.close()
    var line : string
    while readline(inf,line):
        result.add(line)

proc play_round(p1, p2 : var seq[int]) =
    let card1 = p1[0]
    let card2 = p2[0]
    
    echo("round cards: ",card1," " ,card2)
    if card1>card2:
        echo("player1 won")
        # player1 won
        p1.add(card1)
        p1.add(card2)
    else:
        echo("player2 won")
        # player2 won
        p2.add(card2)
        p2.add(card1)
    
    p1.delete(0,0)
    p2.delete(0,0)


    echo("cards at end of round:")
    echo(p1)
    echo(p2)

proc calc_score(p : seq[int]) : int =
    if len(p)==0:
        return
    var index = 1
    result = 0
    for i in countdown(len(p)-1,0):
        echo("\t",i, " ",p[i])
        result += (p[i]*index)
        index += 1
    

proc part1() =
    var player1 : seq[int]
    var player2 : seq[int]
    var is_player1 = true
    # let data = readfile("test_input.txt")
    let data = readfile("input.txt")
    for index,line in data:
        if line.startsWith("Player 1"):
            continue
        if line.startsWith("Player 2"):
            is_player1 = false
            continue
        if line == "":
            continue

        # echo("going to do something with this: ",line)
        if is_player1:
            player1.add(parseInt(line))
        else:
            player2.add(parseInt(line))


    echo("player1: ",player1)
    echo("player2: ",player2)


    while true:
        play_round(player1,player2)

        if len(player1)==0:
            echo("player1 lost")        
            break
        elif len(player2)==0:
            echo("player2 lost")
            break

    echo( calc_score(player1) )
    echo( calc_score(player2) )

part1()
