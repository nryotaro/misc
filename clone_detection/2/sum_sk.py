#!/usr/bin/env python
# -*- coding: utf-8 -*-

class Cls:
    def __init__(self,name, wmc, dit, noc,cbo,rfc, lcom,ca,npm):
        self.name=name
        self.wmc=wmc
        self.dit=dit
        self.noc=noc
        self.cbo=cbo
        self.rfc=rfc
        self.lcom=lcom
        self.ca=ca
        self.npm=npm


if __name__ == '__main__':
    import sys,re
    from functools import reduce
    lines = [ l.rstrip() for l in sys.stdin.readlines()]
    def parse_line(l):
        reg=re.match(r"^([^ ]+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+)$", l)
        return Cls(reg.group(1), int(reg.group(2)), int(reg.group(3)),
          int(reg.group(4)), int(reg.group(5)),int(reg.group(6)),
          int(reg.group(7)), int(reg.group(8)), int(reg.group(9)))

    cks=list(filter(lambda c: None == re.match(r"^.foo*$",c.name),
      [parse_line(l) for l in lines]))
    """
    for c in cks:
        print(c.name)
    """
    print (reduce(lambda acc,ck: acc+ ck.wmc, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.dit, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.noc, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.cbo, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.rfc, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.lcom, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.ca, cks, 0))
    print (reduce(lambda acc,ck: acc+ ck.npm, cks, 0))
