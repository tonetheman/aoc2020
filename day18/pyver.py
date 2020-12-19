


ADD = -1
MULT = -2
EMPTY = -3

def peek(stack,depth=1):
    try:
        return stack[-depth]
    except:
        return EMPTY

def handle_operations(stack):
    if peek(stack,2)==ADD:
        operand2 = stack.pop()
        stack.pop() # ignore plus
        operand1 = stack.pop()
        stack.append(operand1+operand2)
    if peek(stack,2)==MULT:
        operand2 = stack.pop()
        stack.pop() # ignore plus
        operand1 = stack.pop()
        stack.append(operand1*operand2)

def teval(s):
    # stack of stacks
    meta = [ [] ]

    # current stack
    stack = meta[0]

    for c in s:

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

            handle_operations(stack)
            continue

        # handle whitespace
        if c in ' ':
            continue

        # handle numbers
        if c in ['0','1','2','3','4','5','6','7','8','9']:
            stack.append(int(c))

            handle_operations(stack)
            
            continue

        # handle operands
        if c == '+':
            stack.append(ADD)
            continue

        if c == '*':
            stack.append(MULT)
            continue

    # print "stack at end",stack
    return stack[-1]

def test():
    assert 3 == teval("1 + 2")
    assert 71  == teval("1 + 2 * 3 + 4 * 5 + 6")
    assert 7 == teval("1 + (2 * 3)")
    assert 51 == teval("1 + (2 * 3) + (4 * (5 + 6))")
    assert 26 == teval("2 * 3 + (4 * 5)")
    assert 437 == teval("5 + (8 * 3 + 9 + 3 * 4 * 3)")
    assert 12240 == teval("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
    assert 13632 == teval("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")


def part1():
    lines = open("input.txt","r").readlines()
    import string
    lines = map(string.strip,lines)

    _sum = 0

    for line in lines:
        _sum = _sum + teval(line)

    print(_sum)

part1()