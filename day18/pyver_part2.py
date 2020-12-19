


ADD = -1
MULT = -2
EMPTY = -3

def peek(stack,depth=1):
    try:
        return stack[-depth]
    except:
        return EMPTY

def handle_operations(stack,theend):
    if peek(stack,2)==ADD:
        operand2 = stack.pop()
        stack.pop() # ignore plus
        operand1 = stack.pop()
        stack.append(operand1+operand2)

    if theend:
        if peek(stack,2)==MULT:
            operand2 = stack.pop()
            stack.pop() # ignore plus
            operand1 = stack.pop()
            stack.append(operand1*operand2)

def ps(stack):
    ts = ""
    for x in stack:
        if x==ADD:
            ts = ts + "+"
        elif x==MULT:
            ts = ts + "*"
        else:
            ts = ts + str(x)
    return ts

def pps(meta):
    ts = ""
    for stack in meta:
        ts = ts + ps(stack)
        ts = ts + " "
    return ts

def teval(s):
    # stack of stacks
    meta = [ [] ]

    # current stack
    stack = meta[0]

    for c in s:
        print "DBG:",pps(meta)

        # handle (
        if c == '(':
            # print "need a new stack",meta
            current_stack = meta[-1]
            # print "curren stack is",current_stack
            new_stack = []
            meta.append(new_stack)
            # print "meta with new stack added",meta
            stack = meta[-1]
            # print "stack now set to",stack

        # handle )
        if c == ')':
            # print "new to close out a stack", meta
            stack_to_discard = meta.pop()
            # print "meta after pop",meta

            # reset stack to be correct now
            stack = meta[-1]

            # take the result from the discarded stack
            # push it on
            stack.append(stack_to_discard[-1])

            handle_operations(stack,True)
            continue

        # handle whitespace
        if c in ' ':
            continue

        # handle numbers
        if c in ['0','1','2','3','4','5','6','7','8','9']:
            stack.append(int(c))

            handle_operations(stack,False)
            
            continue

        # handle operands
        if c == '+':
            stack.append(ADD)
            continue

        if c == '*':
            stack.append(MULT)
            continue

    # now eval the stack again?
    while len(stack)!=1:
        handle_operations(stack,True)
    print "stack at end",stack
    return stack[-1]

def test():
    # assert 3 == teval("1 + 2")
    # s = "1 + 2 * 3 + 4 * 5 + 6"
    # print "target",s
    # assert 231  == teval(s)
    s = "1 + (2 * 3) + (4 * (5 + 6))"
    print "target",s
    assert 51 == teval(s)


def part1():
    lines = open("input.txt","r").readlines()
    import string
    lines = map(string.strip,lines)

    _sum = 0

    for line in lines:
        _sum = _sum + teval(line)

    print(_sum)

test()