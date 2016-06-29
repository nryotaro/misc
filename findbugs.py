#!/usr/bin/env python

import xml.etree.ElementTree as xml

def upd(k, d):
   d[k] = (d[k] + 1 if k in d else 1)

descriptions = {'MS_SHOULD_BE_FINAL': "Field isn't final but should be",
        'EI_EXPOSE_REP2': "May expose internal representation by incorporating reference to mutable object",
        'EI_EXPOSE_REP': "May expose internal representation by returning reference to mutable object",
        'SS_SHOULD_BE_STATIC': "Unread field: should this field be static?",
        'MS_MUTABLE_ARRAY': "Field is a mutable array", 
        'URF_UNREAD_FIELD': "Unread field", 
        'MS_FINAL_PKGPROTECT': "Field should be both final and package protected",
        'ST_WRITE_TO_STATIC_FROM_INSTANCE_METHOD': "Write to static field from instance method",
        'NP_LOAD_OF_KNOWN_NULL_VALUE': "Load of known null value",
        'DLS_DEAD_LOCAL_STORE': "Dead store to local variable"}

if __name__ == '__main__':

    doc = xml.parse('findbugs/findbugs_report.xml')
    import re   

    c = dict()

    for a in filter(lambda e: re.search('^jp\.go\.mlit\.oss\.trp',e.find('Class').get('classname')), 
            doc.iter('BugInstance')):
        upd(a.get('type'), c)
        #print(a.get('type'))

    from functools import reduce

    print("total: " + str(reduce(lambda acc,e: int(c[e])+acc, c.keys(),0)))

    for k, v in sorted(c.items(), key= lambda x:x[1], reverse=True):
        def p(k):
            return descriptions[k] if k in descriptions  else ""
        print(k + " " + str(v) + " " + p(k))
