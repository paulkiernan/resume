%&program=xelatex
%&encoding=UTF-8 Unicode

% Conventional Resume Class
% A plain, single-column, one-page resume for recruiter pipelines and ATS
% parsers. Companion to dnd-resume.cls; shares the vendored Lato/Raleway
% fonts, resolved relative to the repo root (TEXINPUTS=.:./fonts:).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{standard-resume}[2026/09/04 Conventional one-page resume class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% === Packages ===
\RequirePackage[letterpaper, top=0.35in, bottom=0.3in, left=0.5in, right=0.5in]{geometry}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{enumitem}
\RequirePackage[no-math]{fontspec}
\RequirePackage{hyperref}

% === Colors: one accent, black text, red only for unfilled facts ===
\definecolor{accent}{HTML}{1B4F72}
\definecolor{fillred}{HTML}{C00000}

\hypersetup{
    colorlinks=true,
    linkcolor=accent,
    urlcolor=accent,
    citecolor=accent,
}

% === Fonts ===
% Lato for body text, Raleway for the name and section headers. Ligatures
% are off so extracted text stays plain ASCII for ATS parsers.
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[
    Path=fonts/lato/,
    Extension=.ttf,
    BoldFont=Lato-Bol,
    ItalicFont=Lato-RegIta,
    BoldItalicFont=Lato-BolIta,
    Ligatures=NoCommon,
]{Lato-Reg}
\newfontfamily{\headfont}[
    Path=fonts/raleway/,
    Extension=.otf,
    BoldFont=Raleway-Bold,
]{Raleway-SemiBold}
\newfontfamily{\lightfont}[
    Path=fonts/lato/,
    Extension=.ttf,
    Ligatures=NoCommon,
]{Lato-Lig}
\newcommand{\stdbold}{\bfseries}

% === Type scale (tuned so the full document fits one page) ===
\renewcommand{\normalsize}{\fontsize{9pt}{10.6pt}\selectfont}
\renewcommand{\small}{\fontsize{8pt}{9.8pt}\selectfont}
\newcommand{\datefont}{\lightfont\fontsize{8.5pt}{10.5pt}\selectfont}

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
\newcommand{\name}[1]{%
    {\centering\headfont\bfseries\fontsize{22pt}{24pt}\selectfont #1\par}%
    \vspace{1pt}%
}
\newcommand{\tagline}[1]{%
    {\centering\headfont\color{accent}\fontsize{10.5pt}{12.5pt}\selectfont #1\par}%
    \vspace{1pt}%
}
\newcommand{\contactline}[1]{%
    {\centering\fontsize{8.5pt}{10.5pt}\selectfont #1\par}%
    \vspace{1pt}%
}
% Bullet separator for the contact line
\newcommand{\sep}{\hspace{0.35em}{\color{accent}\textbullet}\hspace{0.35em}}

% --- Section header: letterspaced caps over a thin accent rule ---
\newcommand{\resumesection}[1]{%
    \vspace{4pt}%
    {\headfont\bfseries\color{accent}\fontsize{10pt}{12pt}\selectfont
     \addfontfeatures{LetterSpace=6}\MakeUppercase{#1}\par}%
    \vspace{0.5pt}%
    {\color{accent}\hrule height 0.7pt}%
    \vspace{2.5pt}%
}

% --- Summary paragraph under its own section header ---
\newcommand{\summary}[1]{%
    \resumesection{Summary}%
    #1\par%
}

% --- Experience ---
\newcommand{\employer}[3]{% {NAME}{LOCATION}{DATES}
    \vspace{3.5pt}%
    {\stdbold\fontsize{10pt}{12pt}\selectfont #1}%
    \if\relax\detokenize{#2}\relax\else\ \textemdash\ #2\fi%
    \hfill{\datefont #3}\par%
}
\newcommand{\role}[2]{% {TITLE}{DATES}
    \vspace{1.5pt}%
    {\stdbold\itshape #1}\hfill{\datefont #2}\par%
}

% --- Tight bullet list ---
\newenvironment{bullets}{%
    \begin{itemize}[leftmargin=1.05em, labelsep=0.45em, itemsep=0.5pt,
                    parsep=0pt, topsep=1pt, partopsep=0pt,
                    label={\raisebox{0.1ex}{\small\textbullet}}]%
}{%
    \end{itemize}%
}

% --- Skills row: bold label, hanging indent on wrapped lines ---
\newcommand{\skillrow}[2]{% {LABEL}{LIST}
    \hangindent=1.2em\hangafter=1%
    {\stdbold #1:}\ #2\par%
    \vspace{0.5pt}%
}

% --- Compact one-paragraph block (education, patents) ---
\newcommand{\compactblock}[1]{%
    \begingroup\hangindent=1.2em\hangafter=1%
    #1\par%
    \endgroup\vspace{0.5pt}%
}

% --- Unfilled fact: loud, bold, red, impossible to send by accident ---
\newcommand{\needs}[1]{{\stdbold\color{fillred}[FILL: #1]}}
