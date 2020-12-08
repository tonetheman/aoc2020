

data = open("test_input.txt","r").readlines()
import string
data = map(string.strip,data)

import re
P = re.compile("^(\d+)\s+(.*)")

class Bag:
    def __init__(self,count,color):
        self.count = count
        self.color = color
    def __repr__(self):
        return "dbg:bag:{0}-{1}".format(self.count,self.color)

class BigBag:
    def __init__(self):
        self.bag = None
        self.others = []

for line in data:
    line_data = line.split(" bags contain")
    bag = Bag(1,line_data[0])

    contains_data = line_data[1].split(",")
    for cline in contains_data:
        if cline[0]==' ':
            cline = cline[1:]
        print "\t","cline",cline
        M = P.search(cline)
        if M is not None:
            (count,color) = M.groups(1)
            print "\t","count is",count,"color is",color
        else:
            print "\t",  "nothing contains"
        

    print line_data
    print "bag is",bag
    
