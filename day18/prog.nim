import strutils

const OPERS = {"+"}

proc empty(s : seq[string]) : bool =
  return len(s)==0

proc peek(s : seq[string]) : string =
  if s.empty():
    return " "
  else:
    return s[^1]

proc eval(s : string) =
  echo("eval started")
  var stack : seq[string]
  
  for c in s:
    echo "current char: ",c

    if c in Whitespace:
      continue
    elif c in Digits:
      if stack.empty():
        # stack was empty just add it to stack
        # and keep going
        stack.add($(c))
      else:
        if stack.peek() in OPERS:
          let operation = stack.pop()
          echo("operation is ",operation)
          let operand1 = parseInt(stack.pop())
          let operand2 = parseInt(c)


        else:
          stack.add(c)
    elif c in OPERS:
      stack.add(c)
    

    echo("stack at the end: ",stack)
      




  echo("eval ended")
  echo("")


var s : string

s = "1  + 2"
eval(s)

# s = "1 + (2+3) + ( 4 * ( 5 +6) )"
# eval(s)
