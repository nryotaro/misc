#!/usr/bin/env python
# -*- coding: utf-8 -*-

if __name__ == '__main__':
    import sys,csv
    from openpyxl import load_workbook

    wb = load_workbook(sys.argv[1])
    sheet = wb.get_sheet_by_name(sys.argv[2])
    col= sys.argv[3]
    row_s=sys.argv[4]
    row_e=sys.argv[5]

    for a in range(int(row_s), int(row_e)+1):
        print(sheet[col + str(a)].value)