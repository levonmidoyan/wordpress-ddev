#!/usr/bin/env python
# -*- coding: utf-8 -*- #

import re
import sys

re_insert = re.compile(r'^insert into `(.*)` \(.*\) values (.*);', re.IGNORECASE)

# Define the max values per extenteded insert.
num_extended_inserts = 1000

# Define number of batches before each transaction.
batch_transactions = 30

current_table = ''
row_num = 0
batch_count = 0

for line in sys.stdin:
    row_num += 1
    if line.startswith('INSERT INTO'):
        m = re_insert.match(line)
        table = m.group(1)
        values = m.group(2)

        if table != current_table or row_num >= num_extended_inserts:
            batch_count += 1
            if current_table != '':
                sys.stdout.write(";\n\n")
                if batch_count > batch_transactions:
                    sys.stdout.write("\n\nCOMMIT;\n\nSTART TRANSACTION;\n\n")
                    batch_count = 0
            else:
                sys.stdout.write("\n\nSET autocommit=0;\n\nSTART TRANSACTION;\n\n")
            current_table = table
            sys.stdout.write('INSERT INTO `' + table + '` VALUES ' + values)
            #sys.stdout.write('INSERT INTO `' + table + '` VALUES...')
            row_num = 0
        else:
            sys.stdout.write(',' + values)
    else:
        if current_table != '':
            sys.stdout.write(";\n\nCOMMIT;\n\nSET autocommit=1;\n\n")
            current_table = ''
        sys.stdout.write(line)

if current_table != '':
    sys.stdout.write(";\n\nCOMMIT;\n\n")
