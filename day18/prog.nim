import strutils
import re

let OPERS = { '+', '*' }

# these are how things are reprensented on
# the stack
const ADD = -1
const MUL = -2
const EMPTY = -100

# holds INTs not chars
type Stack = seq[int]
type StackOStacks = seq[Stack]

proc empty(s : Stack) : bool =
  return len(s)==0

proc peek(s : Stack, depth : int = 1) : int =
  # cheeseball way out of not keeping up with
  # anything
  try:
    return s[^depth]
  except:
    return EMPTY

proc eval(s:string) : int =
  
  # need a stack of stacks
  var metaStack : StackOStacks
  
  # need the first stack
  var stack : Stack
  metaStack.add(stack)

  for c in s:
    let current = c
    echo("current is: ",current)

    # spaces we ignore
    if current in Whitespace:
      continue

    # digits we need to do work
    if current in Digits:
      # push the number on the stack
      stack.add(parseInt($(current)))

      if stack.peek(2) == ADD:
        echo("\tneed to add now")
        let operand2 = stack.pop()
        discard stack.pop() # the +
        let operand1 = stack.pop()
        stack.add(operand1+operand2)
        continue
      if stack.peek(2) == MUL:
        echo("\tneed to mul now")
        let operand2 = stack.pop()
        discard stack.pop() # the +
        let operand1 = stack.pop()
        stack.add(operand1*operand2)
        continue
    
    # operands + * we need to save
    if current in OPERS:
      if current=='+':
        stack.add(ADD)
        continue
      elif current == '*':
        stack.add(MUL)
        continue
    
    if current == '(':
      # need to make a new stack
      # and assign out the stack
      # not sure how to do that with nim
      discard

    if current == ')':
      discard
  
  echo("stack at end: ",stack)
  return stack[^1]

proc tony_simple_test() =
  assert 3 == eval("1 + 2")
  assert 9 == eval("1   + 2*3")
  assert 71 == eval("1 + 2 * 3 + 4 * 5 + 6")

tony_simple_test()

