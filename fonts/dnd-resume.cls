%&program=xelatex
%&encoding=UTF-8 Unicode

% D&D Character Sheet Resume Class
% Formats a professional resume as a Dungeons & Dragons 5e character sheet
\ProvidesClass{dnd-resume}[2024/01/01 DnD Character Sheet Resume Class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% === Package Imports ===
\usepackage[letterpaper, top=0.25in, bottom=0.25in, left=0.4in, right=0.4in]{geometry}
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage{tikz}
\usepackage{enumitem}
\usepackage{hyperref}
\usepackage[no-math]{fontspec}
\usepackage{xltxtra,xunicode}

\usetikzlibrary{positioning, calc, shapes.geometric, decorations.pathmorphing, decorations.markings}

% === D&D 5e PHB Color Palette ===
\definecolor{parchment}{HTML}{FDF1DC}
\definecolor{parchmentdark}{HTML}{F5E6C8}
\definecolor{dndred}{HTML}{58180D}
\definecolor{accentred}{HTML}{9C2B1B}
\definecolor{textmain}{HTML}{231F20}
\definecolor{textlight}{HTML}{4E4B46}
\definecolor{rulegold}{HTML}{C9AD6A}
\definecolor{rulegolddark}{HTML}{B8963A}
\definecolor{bordertan}{HTML}{D4BC8B}
\definecolor{borderdark}{HTML}{A0845C}

% === Hyperref Config ===
\hypersetup{
    colorlinks=true,
    linkcolor=dndred,
    urlcolor=dndred,
    citecolor=dndred,
}

% === Fonts ===
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[
    Color=textmain,
    Path=fonts/lato/,
    BoldFont=Lato-Bol,
    ItalicFont=Lato-RegIta,
    BoldItalicFont=Lato-BolIta,
]{Lato-Reg}
\setsansfont[
    Scale=MatchLowercase,
    Mapping=tex-text,
    Path=fonts/raleway/,
    BoldFont=Raleway-Bold,
]{Raleway-Medium}

\newcommand{\dndheading}{\fontspec[Path=fonts/lato/]{Lato-Bol}\selectfont}
\newcommand{\dndlight}{\fontspec[Path=fonts/lato/]{Lato-Lig}\selectfont}
\newcommand{\dndheavy}{\fontspec[Path=fonts/raleway/]{Raleway-Heavy}\selectfont}
\newcommand{\dndbold}{\fontspec[Path=fonts/lato/]{Lato-Bol}\selectfont}
\newcommand{\dndreg}{\fontspec[Path=fonts/lato/]{Lato-Reg}\selectfont}
\newcommand{\dnditalic}{\fontspec[Path=fonts/lato/]{Lato-LigIta}\selectfont}
\newcommand{\dndsemibold}{\fontspec[Path=fonts/raleway/]{Raleway-SemiBold}\selectfont}
\newcommand{\dndextrabold}{\fontspec[Path=fonts/raleway/]{Raleway-ExtraBold}\selectfont}
\newcommand{\dndbolditalic}{\fontspec[Path=fonts/lato/]{Lato-BolIta}\selectfont}

% === Page Setup ===
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\pagecolor{parchment}

% ============================================================
% DECORATIVE PAGE BORDER + SIDEBAR TINT (single overlay)
% ============================================================
% Page border only (called at start of document)
\newcommand{\pagedecor}{%
    \begin{tikzpicture}[remember picture, overlay]
        % Outer border
        \draw[borderdark, line width=1.8pt, rounded corners=4pt]
            ([shift={(5pt,-5pt)}]current page.north west)
            rectangle
            ([shift={(-5pt,5pt)}]current page.south east);
        % Inner border
        \draw[rulegold, line width=0.5pt, rounded corners=3pt]
            ([shift={(9pt,-9pt)}]current page.north west)
            rectangle
            ([shift={(-9pt,9pt)}]current page.south east);
        % Corner ornaments (small diamonds at each corner)
        \foreach \corner/\xsh/\ysh in {
            north west/12pt/-12pt,
            north east/-12pt/-12pt,
            south west/12pt/12pt,
            south east/-12pt/12pt%
        } {
            \fill[rulegolddark]
                ([shift={(\xsh,\ysh)}]current page.\corner)
                ++(0,3pt) -- ++(3pt,0) -- ++(0,-3pt) -- ++(-3pt,0) -- cycle;
        }
    \end{tikzpicture}%
}

% Mark where the columns start (place just before minipages)
\newcommand{\marksidebarstart}{%
    \tikz[remember picture] \coordinate (sidebarstart) at (0,0);%
}

% Draw sidebar tint from saved coordinate to page bottom (call at end)
\newcommand{\drawsidebar}{%
    \begin{tikzpicture}[remember picture, overlay]
        % Tinted sidebar from column start to bottom of page
        \fill[parchmentdark, opacity=0.5]
            ([shift={(0pt,3pt)}]sidebarstart -| current page.west)
            ++(9.5pt,0)
            rectangle
            ([shift={(2.25in,9.5pt)}]current page.south west);
        % Right edge line
        \draw[borderdark, line width=0.3pt, opacity=0.4]
            ([shift={(2.25in,3pt)}]sidebarstart -| current page.west)
            -- ([shift={(2.25in,9.5pt)}]current page.south west);
    \end{tikzpicture}%
}

% ============================================================
% CUSTOM COMMANDS
% ============================================================

% --- Character Name (large header, no center env) ---
\newcommand{\charactername}[1]{%
    \par\vspace{4pt}%
    \noindent\centering%
    {\dndheavy\fontsize{30pt}{32pt}\selectfont\color{dndred}#1}%
    \par\vspace{2pt}%
}

% --- Character Subtitle (italic tagline, no center env) ---
\newcommand{\charactersub}[1]{%
    \noindent\centering%
    {\dnditalic\fontsize{9.5pt}{11pt}\selectfont\color{textlight}#1}%
    \par\vspace{4pt}%
}

% --- Ornamental Thick Rule (major section divider with gold accent) ---
\newcommand{\thickrule}{%
    \par\vspace{1pt}%
    \noindent%
    \begin{tikzpicture}[x=1pt, y=1pt]
        \useasboundingbox (0,-2) rectangle (\linewidth,2);
        % Main red rule
        \fill[dndred] (0,-1) rectangle (\linewidth,1);
        % Gold accent lines
        \draw[rulegold, line width=0.3pt] (0,1.5) -- (\linewidth,1.5);
        \draw[rulegold, line width=0.3pt] (0,-1.5) -- (\linewidth,-1.5);
        % Center diamond ornament
        \fill[rulegold] (\linewidth/2, 0) ++(0,3.5) -- ++(3.5,-3.5) -- ++(0,0) -- ++(-3.5,-3.5) -- ++(-3.5,3.5) -- ++(3.5,3.5);
    \end{tikzpicture}%
    \par\vspace{1pt}%
}

% --- Ornamental Thin Rule (minor section divider) ---
\newcommand{\thinrule}{%
    \par\vspace{1pt}%
    \noindent%
    \begin{tikzpicture}[x=1pt, y=1pt]
        \useasboundingbox (0,-1.5) rectangle (\linewidth,1.5);
        \draw[dndred, line width=0.6pt] (0,0) -- (\linewidth,0);
        % Small terminal flourishes
        \fill[dndred] (0,0) circle (1.2pt);
        \fill[dndred] (\linewidth,0) circle (1.2pt);
    \end{tikzpicture}%
    \par\vspace{1pt}%
}

% --- Section Header (D&D style uppercase with flourish underline) ---
\newcommand{\dndsection}[1]{%
    \vspace{4pt}%
    {\color{dndred}\dndheading\fontsize{12pt}{14pt}\selectfont\uppercase{#1}}%
    \par\vspace{1pt}%
    \noindent%
    \begin{tikzpicture}[x=1pt, y=1pt]
        \useasboundingbox (0,-2.5) rectangle (\linewidth,1);
        % Main rule with tapered ends
        \fill[dndred] (0,-0.25) rectangle (\linewidth,0.25);
        % Small diamond at left
        \fill[rulegolddark] (4,0) ++(0,2) -- ++(2,-2) -- ++(-2,-2) -- ++(-2,2) -- cycle;
    \end{tikzpicture}%
    \par\vspace{1pt}%
}


% --- Ability Score Box (larger, refined with double border) ---
\newcommand{\tinyabilitybox}[2]{% {NAME}{SCORE}
    \begin{tikzpicture}[baseline=(label.base)]
        % Outer frame
        \draw[dndred, line width=1.2pt, rounded corners=2.5pt]
            (0, 0) rectangle (1.1cm, 1.4cm);
        % Inner decorative border
        \draw[rulegold, line width=0.3pt, rounded corners=2pt]
            (0.05cm, 0.05cm) rectangle (1.05cm, 1.35cm);
        % Score (large number)
        \node[font=\fontsize{16pt}{16pt}\dndbold, text=textmain]
            at (0.55cm, 1.05cm) {#2};
        % Modifier (calculated)
        \pgfmathtruncatemacro{\modifier}{floor((#2 - 10) / 2)}
        \node[font=\fontsize{7pt}{7pt}\selectfont\dndreg, text=dndred]
            at (0.55cm, 0.55cm)
            {(\ifnum\modifier<0\relax\modifier\else+\modifier\fi)};
        % Ability name label
        \node[font=\fontsize{5pt}{5pt}\dndheading, text=dndred]
            (label) at (0.55cm, 0.20cm) {\uppercase{#1}};
    \end{tikzpicture}%
}

% --- Stat Line (label: value pairs) ---
\newcommand{\statline}[2]{%
    {\dndbold\fontsize{9pt}{11pt}\selectfont\color{dndred}#1}~%
    {\dndreg\fontsize{9pt}{11pt}\selectfont #2}%
}

% --- Quest Header (employer + campaign name + dates) ---
\newcommand{\questheader}[2]{% {EMPLOYER --- CAMPAIGN}{DATES}
    \vspace{5pt}%
    {\dndbold\fontsize{10.5pt}{12pt}\selectfont\color{dndred}#1}%
    \hfill%
    {\dndlight\fontsize{8.5pt}{10pt}\selectfont\color{textlight}#2}%
    \par\vspace{1pt}%
}

% --- Quest Role (job title + dates) ---
\newcommand{\questrole}[2]{% {ROLE TITLE}{DATES}
    {\dndsemibold\fontsize{9.5pt}{11pt}\selectfont\color{textmain}#1}%
    \hfill%
    {\dndlight\fontsize{8pt}{10pt}\selectfont\color{textlight}#2}%
    \par%
}

% --- Quest Details (bullet list with red diamond bullets) ---
\newenvironment{questdetails}{%
    \begin{itemize}[leftmargin=10pt, itemsep=0pt, parsep=0pt, topsep=0pt,
                     label={\raisebox{0.5pt}{\tikz\fill[dndred] (0,0) -- (2.5pt,1.5pt) -- (5pt,0) -- (2.5pt,-1.5pt) -- cycle;}}]%
    \raggedright%
    \fontsize{8.5pt}{10.5pt}\selectfont%
}{%
    \end{itemize}%
    \vspace{0pt}%
}

% --- Magic Item Entry (named projects as equipment) ---
\newcommand{\magicitem}[3]{% {NAME}{RARITY/TYPE}{DESCRIPTION}
    {\dndbold\fontsize{9.5pt}{11pt}\selectfont\color{textmain}#1}%
    ~{\dnditalic\fontsize{8pt}{10pt}\selectfont\color{dndred}#2}%
    \par%
    {\fontsize{8.5pt}{10.5pt}\selectfont #3}%
    \par\vspace{4pt}%
}

% --- Proficiency Level (skill tier + items) ---
\newcommand{\proflevel}[2]{% {LEVEL}{ITEMS}
    {\dndbold\fontsize{8.5pt}{10pt}\selectfont\color{dndred}#1:}~%
    {\fontsize{8.5pt}{10pt}\selectfont #2}%
    \par%
}

% --- Character Info Item (for the info bar) ---
\newcommand{\charinfo}[2]{% {LABEL}{VALUE}
    {\dndbold\fontsize{8pt}{9pt}\selectfont\color{dndred}#1}~%
    {\dndreg\fontsize{8pt}{9pt}\selectfont #2}%
}

% --- Trait Box (personality traits, ideals, bonds, flaws) ---
\newcommand{\traitbox}[2]{% {LABEL}{CONTENT}
    \vspace{2pt}%
    {\dndbold\fontsize{9pt}{11pt}\selectfont\color{dndred}#1.}~%
    {\fontsize{8.5pt}{10.5pt}\selectfont #2}%
    \par%
}

% --- Feature Entry (special abilities) ---
\newcommand{\dndfeature}[2]{% {NAME}{DESCRIPTION}
    {\dndbolditalic\fontsize{9pt}{11pt}\selectfont\color{textmain}#1.}~%
    {\fontsize{8.5pt}{10.5pt}\selectfont #2}%
    \par\vspace{3pt}%
}

% --- Sidebar Section Header (with gold underline accent) ---
\newcommand{\sidebarsection}[1]{%
    \vspace{2pt}%
    {\color{dndred}\dndheading\fontsize{9pt}{11pt}\selectfont\uppercase{#1}}%
    \par\vspace{0.5pt}%
    \noindent%
    \begin{tikzpicture}[x=1pt, y=1pt]
        \useasboundingbox (0,-1.5) rectangle (\linewidth,0.5);
        \draw[dndred, line width=0.4pt] (0,0) -- (\linewidth,0);
        \draw[rulegold, line width=0.2pt] (0,-1.2) -- (\linewidth,-1.2);
    \end{tikzpicture}%
    \par\vspace{0.5pt}%
}

% --- Impact Metric (bold value + italic context) ---
\newcommand{\impactmetric}[2]{% {VALUE}{CONTEXT}
    {\dndbold\fontsize{7.5pt}{9pt}\selectfont\color{dndred}#1}\\%
    {\dnditalic\fontsize{6.5pt}{8pt}\selectfont\color{textlight}#2}%
    \par\vspace{2pt}%
}

% --- Sidebar Stat Line (smaller) ---
\newcommand{\sidestat}[2]{%
    {\dndbold\fontsize{8pt}{10pt}\selectfont\color{dndred}#1}~%
    {\dndreg\fontsize{8pt}{10pt}\selectfont #2}%
}

% --- Decorative Diamond Divider ---
\newcommand{\diamonddivider}{%
    \begin{center}%
    \vspace{4pt}%
    \begin{tikzpicture}
        \draw[dndred, line width=0.4pt] (0,0) -- (1.8,0);
        \fill[dndred] (2.0,0) -- (2.12,0.1) -- (2.24,0) -- (2.12,-0.1) -- cycle;
        \draw[dndred, line width=0.4pt] (2.44,0) -- (4.24,0);
    \end{tikzpicture}%
    \vspace{4pt}%
    \end{center}%
}
