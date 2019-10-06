#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Resume Content Parser

Reads a YAML file containing the content of a resume and produces a .tex
file to compile

NOTE: This must be run using python3 :)
"""

# Future-proof
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

# Standard Library Imports
from argparse import ArgumentParser
from datetime import date
from string import Template
import sys

# Third Party Librarier
import yaml


def transform_yaml_resume_to_tex(input_filename, output_filename):
    """
    Transform an input YAML resume document into a TeX document that can
    be compiled into a resume.

    @param input_filename: str, name of the input YAML file to parse
    @param output_filename: str, name of the output TeX file to write
    """

    with open(input_filename, 'r') as infile:
        resume_content = yaml.load(infile)

    resume_header = Template(r"""
    \lastupdated
    \namesection{$first_name}{$last_name}{
        \urlstyle{same}\url{$website} \\
        \href{mailto:$email}{$email} \hspace{1mm}|\hspace{1mm} $phone
    }
    """).substitute(
        first_name=resume_content['name']['first'],
        last_name=resume_content['name']['last'],
        website=resume_content['website'],
        email=resume_content['email'],
        phone=resume_content['phone'],
    )

    jobs = []
    for job in resume_content['experience']:

        _start_date = job['period-of-employment']['start']
        _end_date = job['period-of-employment']['end']

        details = []
        for detail in job['details']:
            details.append(Template(r"""
                \item
                    $detail
            """).substitute(detail=detail))

        jobs.append(Template(r"""
            \runsubsection{\href{$website}{$company_name}}
                \location{\hfill $start_date – $end_date}
                \descript{$job_title}
                \begin{tightemize}
                    $details
                \end{tightemize}
            \sectionsep
        """).substitute(
            website=job['employer-website'],
            company_name=job['employer-name'],
            start_date=_start_date.strftime("%B %Y") if isinstance(_start_date, date) else _start_date,
            end_date=_end_date.strftime("%B %Y") if isinstance(_end_date, date) else _end_date,
            job_title=job['title'],
            details="".join(details),
        ))

    complete_resume = Template(r"""
    \RequirePackage{fix-cm}
    \RequirePackage[l2tabu, orthodox]{nag}
    \documentclass[]{resume-openfont}
    \usepackage{microtype}

    \begin{document}

    $resume_header

    \section{Experience}

    $job_experience

    \end{document}
    """).substitute(
        resume_header=resume_header,
        job_experience="".join(jobs),
    )

    with open(output_filename, 'w') as outfile:
        outfile.write(complete_resume)


def main():
    """
    Main Program Entry Point

    Define arguments and compile resume TeX
    """

    argparser = ArgumentParser((
        'Resume builder. Takes a YAML file a input and produces a TeX '
        'file that can be whittled down into a cohesive resume.'
    ))
    argparser.add_argument(
        "-i", dest="input_filename", default='resume.yaml', metavar="FILE",
        help="input YAML file to parse for resume content",
    )
    argparser.add_argument(
        "-o", dest="output_filename", default='test-resume.tex', metavar="FILE",
        help="output file to write resume TeX into",
    )
    arguments = argparser.parse_args()

    transform_yaml_resume_to_tex(
        arguments.input_filename,
        arguments.output_filename
    )

if __name__ == "__main__":
    sys.exit(main())
