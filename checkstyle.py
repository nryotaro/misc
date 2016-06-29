#!/usr/bin/env python

import xml.etree.ElementTree as xml

doc = xml.parse('checkstyle/checkstyle-report.xml')

def upd(k, d):
   d[k] = (d[k] + 1 if k in d else 1)

descriptions= {'com.puppycrawl.tools.checkstyle.checks.sizes.LineLengthCheck' : "Checks for long lines.",
        'com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocStyleCheck': "Custom Checkstyle Check to validate Javadoc.",
        'com.puppycrawl.tools.checkstyle.checks.design.DesignForExtensionCheck': "Checks that classes are designed for inheritance.",
        'com.puppycrawl.tools.checkstyle.checks.FinalParametersCheck': "Check that method/constructor/catch/foreach parameters are final.", 
        'com.puppycrawl.tools.checkstyle.checks.whitespace.ParenPadCheck': "Checks the padding of parentheses; that is whether a space is required after a left parenthesis and before a right parenthesis, or such spaces are forbidden, with the exception that it does not check for padding of the right parenthesis at an empty for iterator."}

if __name__ == '__main__':

    c=dict()
    for a in [b.get('source') for a in doc.iter('file') for b in a.iter('error')]:
        upd(a,c)

    from functools import reduce

    print("total: " + str(reduce(lambda acc,e: int(c[e])+acc, c.keys(),0)))

    for k, v in sorted(c.items(), key= lambda x:x[1], reverse=True):
        def p(k):
            return descriptions[k] if k in descriptions  else ""
        print(k + " " + str(v) + " " + p(k))

