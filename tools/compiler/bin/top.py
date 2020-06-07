#!/usr/bin/env python

import os

if __name__ == '__main__':
    depth = "."
    while os.curdir != '/':
        depth = depth + "/.."
        os.chdir("..")
        files = os.listdir('.')
        try:
            files.index("TOT")
        except ValueError:
            continue
        else:
            break
    print depth
