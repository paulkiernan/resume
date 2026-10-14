%&program=xelatex
%&encoding=UTF-8 Unicode

% Resume Class
% A plain, single-column, one-page resume for recruiter pipelines and ATS
% parsers. Styled to match paulynomial.com: Space Mono for the name,
% headings and dates, Lato for reading text, black and greys only, and the
% site's thick black left rule beside the header as the one signature
% element. Fonts are vendored and resolved relative to the repo root
% (TEXINPUTS=.:./fonts:).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/10/14 One-page resume class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% === Packages ===
\RequirePackage[letterpaper, top=0.4in, bottom=0.3in, left=0.5in, right=0.5in]{geometry}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{enumitem}
\RequirePackage[no-math]{fontspec}
\RequirePackage{hyperref}

% === Colors: black, two greys (as on paulynomial.com), red only for unfilled facts ===
\definecolor{ink}{HTML}{000000}
\definecolor{mid}{HTML}{555555}
\definecolor{faint}{HTML}{999999}
\definecolor{rule}{HTML}{CCCCCC}
\definecolor{fillred}{HTML}{C00000}

\hypersetup{
    colorlinks=true,
    linkcolor=ink,
    urlcolor=ink,
    citecolor=ink,
}

% === Fonts ===
% Lato for reading text; Space Mono for the name, headings and dates.
% Ligatures are off so extracted text stays plain ASCII for ATS parsers.
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[
    Path=fonts/lato/,
    Extension=.ttf,
    BoldFont=Lato-Bol,
    ItalicFont=Lato-RegIta,
    BoldItalicFont=Lato-BolIta,
    Ligatures=NoCommon,
]{Lato-Reg}
\newfontfamily{\monofont}[
    Path=fonts/spacemono/,
    Extension=.ttf,
    BoldFont=SpaceMono-Bold,
    Ligatures=NoCommon,
]{SpaceMono-Regular}
\newcommand{\stdbold}{\bfseries}

% === Type scale (tuned so the full document fits one page) ===
\renewcommand{\normalsize}{\fontsize{9pt}{10.7pt}\selectfont}
\renewcommand{\small}{\fontsize{8pt}{9.8pt}\selectfont}
\newcommand{\datefont}{\monofont\color{mid}\fontsize{7.5pt}{10pt}\selectfont}

% === Page setup ===
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\raggedbottom
\AtBeginDocument{\normalsize\raggedright}

% ============================================================
% MACROS
% ============================================================

% --- Header ---
% \name, \prompt, \tagline and \contactline store their text; \makeheader
% sets them as one block beside the black left rule.
\newcommand{\@resumename}{}
\newcommand{\@prompt}{}
\newcommand{\@tagline}{}
\newcommand{\@contactline}{}
\newcommand{\name}[1]{\def\@resumename{#1}}
\newcommand{\prompt}[1]{\def\@prompt{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\contactline}[1]{\def\@contactline{#1}}
% Gap between contact items
\newcommand{\sep}{\hspace{1.4em}}

\newcommand{\makeheader}{%
    \noindent{\color{ink}\vrule width 3.5pt}\hspace{14pt}%
    \parbox[c]{\dimexpr\linewidth-17.5pt\relax}{%
        \vspace{5pt}%
        {\monofont\color{faint}\fontsize{7.5pt}{9pt}\selectfont\@prompt\par}%
        \vspace{1pt}%
        {\monofont\bfseries\fontsize{21pt}{23pt}\selectfont
         \MakeLowercase{\@resumename}\par}%
        \vspace{1pt}%
        {\monofont\color{mid}\fontsize{8pt}{10pt}\selectfont\@tagline\par}%
        \vspace{5pt}%
        {\fontsize{8.5pt}{10.5pt}\selectfont\@contactline\par}%
        \vspace{4pt}%
    }\par%
    \vspace{3pt}%
}

% --- Section header: lowercase mono label, then a hairline to the margin ---
\newcommand{\resumesection}[1]{%
    \vspace{5.5pt}%
    {\monofont\bfseries\fontsize{9pt}{11pt}\selectfont
     \MakeLowercase{#1}\hspace{8pt}%
     {\color{rule}\leaders\hrule height 0.5pt depth 0pt\hfill}\kern0pt\par}%
    \vspace{3pt}%
}

% --- Summary paragraph under its own section header ---
\newcommand{\summary}[1]{%
    \resumesection{Summary}%
    #1\par%
}

% --- Experience ---
% Each company opens with a black tick (echoing the header rule), a large
% mono name, a grey one-line description and location, and dates; roles and
% bullets are indented beneath it.
\newlength{\bandindent}
\setlength{\bandindent}{13.5pt}
\newenvironment{company}[4]{% {NAME}{WHAT IT IS}{LOCATION}{DATES}
    \par\vspace{8pt}\noindent
    {\color{ink}\vrule width 3.5pt height 10.5pt depth 2.5pt}\hspace{10pt}%
    {\monofont\bfseries\fontsize{12.5pt}{14pt}\selectfont #1}%
    \hspace{0.9em}{\color{mid}#2}%
    \hspace{0.9em}{\color{faint}#3}%
    \hfill{\datefont #4}\par%
    \vspace{1pt}%
    \leftskip=\bandindent%
}{%
    \par%
}
\newcommand{\role}[2]{% {TITLE}{DATES}
    \vspace{2pt}%
    {\stdbold #1}\hfill{\datefont #2}\par%
}
% Bold lead-in at the start of a bullet, so the page scans
\newcommand{\lead}[1]{{\stdbold #1}}

% --- Tight bullet list with grey dash markers, aligned under the company ---
\newenvironment{bullets}{%
    \begin{itemize}[leftmargin=\dimexpr\bandindent+1.1em\relax, labelsep=0.5em,
                    itemsep=0.5pt, parsep=0pt, topsep=1.5pt, partopsep=0pt,
                    label={\color{faint}\textendash}]%
}{%
    \end{itemize}%
}

% --- Label grid (skills, education, patents): grey mono label in a fixed
% left column, content wrapping in its own column on the right ---
\newlength{\gridlabelwidth}
\setlength{\gridlabelwidth}{1.05in}
\newcommand{\skillrow}[2]{% {LABEL}{CONTENT}
    \noindent\makebox[\gridlabelwidth][l]{%
        \monofont\color{mid}\fontsize{7.5pt}{10.7pt}\selectfont\MakeLowercase{#1}}%
    \parbox[t]{\dimexpr\linewidth-\gridlabelwidth\relax}{#2}\par%
    \vspace{2.5pt}%
}

% --- Unfilled fact: loud, bold, red, impossible to send by accident ---
\newcommand{\needs}[1]{{\stdbold\color{fillred}[FILL: #1]}}
