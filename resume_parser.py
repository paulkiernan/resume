#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Resume Content Parser

Reads a YAML file containing the content of a resume and produces a .tex
file to compile
"""

# Future-proof
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

# Standard Library Imports
import sys

# Third Party Librarier
import yaml


def main():
    with open('resume.yaml', 'r') as infile:
        resume_content = yaml.load(infile)

    from pprint import pprint
    print('\n\n\n')
    pprint(resume_content)
    print('\n\n\n')

if __name__ == "__main__":
    sys.exit(main())
