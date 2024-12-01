\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bookneue}[Dec 1, 2024 Book Neue]

%%% NECESSARY PACKAGE LOADING -------------------------------------
\RequirePackage{xcolor-material}
\RequirePackage[many]{tcolorbox}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.15}
\def\logofile{static/mcm-mathstat_left-blk_eps.eps}
\pgfplotsset{tick style={black,thick}}

%%% OPTIONS ---------------------------------------------
\DeclareOption{dark}{
	\definecolor{darkbg}{HTML}{212121}
	\pagecolor{darkbg}
	\color{white}
	\tcbset{coltext=white}
	\pgfplotsset{tick style={white,thick}}
	\def\logofile{static/mcm-mathstat_left-wht_eps.eps}
}
\DeclareOption{midnight}{
	\colorlet{darkbg}{black}
	\pagecolor{darkbg}
	\color{white}
	\tcbset{coltext=white}
	\pgfplotsset{tick style={white,thick}}
	\def\logofile{static/mcm-mathstat_left-wht_eps.eps}
}
\ProcessOptions\relax %----------------------------------

\LoadClass[openany]{book}

\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt}

%%% MATH
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}

%%% COLOUR
\colorlet{main}{MaterialDeepOrange500}

%%% TYPOGRAPHY
\RequirePackage{unicode-math}

% Fixes inline fraction spacing
\RequirePackage{luacode}
\begin{luacode}
 local patch_stix = function (tfmdata)
  if tfmdata.psname == "STIXTwoMath-Regular" then
  
   -- Some of the loaded files do not appear to contain these MathConstants
   -- but I don't know why
   if not (tfmdata.MathConstants and next(tfmdata.MathConstants)) then 
    -- In those cases we simply do nothing
    return
   end
   
   local mc=tfmdata.MathConstants
   
   mc.FractionNumeratorShiftUp     = 0.80 * mc.FractionNumeratorShiftUp
   mc.FractionDenominatorShiftDown = 0.75 * mc.FractionDenominatorShiftDown
  end
 end
 
 luatexbase.add_to_callback(
  "luaotfload.patch_font",patch_stix,
  "my_private_callbacks.patch_stix")
\end{luacode}

% Resets \colon to its usual definition
\renewcommand{\colon}{\nobreak\mskip2mu\mathpunct{}\nonscript\mkern-\thinmuskip{:}\mskip6muplus1mu\relax}

\setmathfont{STIXTwoMath-Regular.otf}[
Path = fonts/,
StylisticSet={1}]

\setmainfont{STIXTwoText}[
Path = fonts/,
Extension = .otf,
UprightFont = *-Regular,
BoldFont = *-Bold,
ItalicFont = *-Italic,
BoldItalicFont = *-BoldItalic
]

\setsansfont{Graphik}[
Path = fonts/,
Extension = .otf,
UprightFont = *Regular,
BoldFont = *Semibold,
ItalicFont = *RegularItalic,
BoldItalicFont = *SemiboldItalic
]

\newfontfamily\TitleFont[Path=fonts/]{GraphikCompact-Bold-Trial.otf}

%%% GRAPHICS AND COLORS
\RequirePackage{tikz}
\input{static/stix_arrows}
\RequirePackage{hyperref}
\hypersetup{hidelinks}

%%% PAGE SETUP, HEADERS AND FOOTERS
\RequirePackage[top=1.5in,left=1.75in,right=1.75in]{geometry}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[RO]{\sffamily\nouppercase\rightmark}
\fancyhead[LE]{\sffamily\nouppercase\leftmark}
\fancyfoot[C]{\sffamily\thepage}

%%% SECTION TITLE AND TOC STYLE
\setcounter{secnumdepth}{3}
\RequirePackage[explicit,newparttoc]{titlesec}
\titleformat{\section}[block]
	{\raggedright\bfseries\sffamily\Large}
	{\llap{\textcolor{main}{\thesection}\hspace{1em}}}
	{0cm}
	{#1}
	[]
\titleformat{\subsection}[block]
	{\bfseries\sffamily\large}
	{\llap{\textcolor{main}{\thesection}\hspace{1em}}}
	{0cm}
	{#1}
	[]
\titleformat{\chapter}[display]
	{\raggedright\Huge\bfseries\sffamily}
	{\LARGE\textcolor{main}{Chapter \thechapter}}
	{0cm}
	{#1}
	[]
\RequirePackage{titletoc}
\titlecontents{chapter}[0em]{\bfseries\sffamily}
{{\color{main}\thecontentslabel}\enspace\enspace}
{}
{\hfill\contentspage}[\vskip 6pt]

\titlecontents{section}[2em]{\sffamily}
{\thecontentslabel\enspace\enspace}
{}
{\titlerule*[0.5pc]{.}\quad\contentspage}[\vskip 4pt]


%%% LISTS AND FLOATS
\RequirePackage{enumitem}
\setlist[enumerate,1]{label={\sffamily\bfseries\color{main}(\alph*)},ref={(\alph*)}}
\setlist[enumerate,2]{label={\sffamily\bfseries\color{main}(\roman*)},ref={(\roman*)}}
\setlist[itemize,1]{label={\color{main}$\mdsmblkcircle$}}
\setlist[itemize,enumerate]{topsep=0pt}
\newenvironment{exercises}{%\subsection*{Exercises}
\begin{enumerate}[label={\sffamily\bfseries\color{main}\arabic*.},ref=\thesection{}.\arabic*,leftmargin=*]}{\end{enumerate}}
\RequirePackage[labelfont=bf]{caption}

%%% STRUCTURED MATH SECTIONS (THEOREMS, PROOFS, EXAMPLES ETC.)
\newtcolorbox{thmbox}{
enhanced jigsaw, breakable,
boxrule=0pt,frame hidden,
colback=main,
opacityback=0.1,
arc=8pt,
before skip=10pt,after skip=10pt,
left=8pt,right=8pt,
top=6pt,bottom=6pt
}
\newtcolorbox{defbox}{
enhanced jigsaw, breakable,
boxrule=1.5pt,
colframe=main,
opacityback=0,
arc=8pt,
before skip=10pt,after skip=10pt,
left=8pt,right=8pt,
top=6pt,bottom=6pt
}
\newtcolorbox{exbox}{
enhanced jigsaw, breakable,
bottomrule=1.5pt,
toprule=1.5pt,
leftrule=0pt,
rightrule=0pt,
colframe=main,
opacityback=0,
sharp corners,
before skip=18pt,after skip=18pt,
left=0pt,right=0pt,
top=6pt,bottom=6pt
}
\newtcolorbox{rmkbox}{
enhanced jigsaw, breakable,
boxrule=0pt,frame hidden,
borderline west={1.5pt}{0pt}{main},
colframe=main,
opacityback=0,
sharp corners,
before skip=10pt,after skip=10pt,
left=6pt,right=6pt,
top=0pt,bottom=0pt
}
\newtcolorbox{alertbox}{
enhanced jigsaw, breakable,
colback=red,
boxrule=0pt,frame hidden,
coltext=white,
sharp corners,
before skip=10pt,after skip=10pt,
left=8pt,right=8pt,
top=6pt,bottom=6pt
}

\newtheoremstyle{colortheorem} % name
{0pt}                    % Space above
{0pt}                    % Space below
{}                   % Body font \itshape
{}                           % Indent amount
{\sffamily\bfseries\color{main}}                   % Theorem head font
{.}                          % Punctuation after theorem head
{.5em}                       % Space after theorem head
{}

\newtheoremstyle{rmkstyle} % name
{0pt}                    % Space above
{0pt}                    % Space below
{}                   % Body font \itshape
{}                           % Indent amount
{\sffamily\itshape\color{main}}                   % Theorem head font
{.}                          % Punctuation after theorem head
{.5em}                       % Space after theorem head
{}

\theoremstyle{colortheorem}
\newtheorem{theoremc}{Theorem}[chapter]
\newtheorem*{theoremcn}{Theorem}
\newtheorem{definitionc}[theoremc]{Definition}
\newtheorem{propositionc}[theoremc]{Proposition}
\newtheorem{corollaryc}[theoremc]{Corollary}
\newtheorem{lemmac}[theoremc]{Lemma}
\newtheorem{examplec}[theoremc]{Example}
\theoremstyle{rmkstyle}
\newtheorem*{remarkc}{Remark}

\newenvironment{theorem}{
	\begin{thmbox}\setlength{\parskip}{6pt}
	\begin{theoremc}
}{
	\end{theoremc}
	\end{thmbox}
}
\newenvironment{theorem*}{
	\begin{thmbox}\setlength{\parskip}{6pt}
	\begin{theoremcn}
}{
	\end{theoremcn}
	\end{thmbox}
}
\newenvironment{definition}{
	\begin{defbox}\setlength{\parskip}{6pt}
	\begin{definitionc}
}{
	\end{definitionc}
	\end{defbox}
}
\newenvironment{proposition}{
	\begin{thmbox}\setlength{\parskip}{6pt}
	\begin{propositionc}
}{
	\end{propositionc}
	\end{thmbox}
}
\newenvironment{lemma}{
	\begin{thmbox}\setlength{\parskip}{6pt}
	\begin{lemmac}
}{
	\end{lemmac}
	\end{thmbox}
}
\newenvironment{corollary}{
	\begin{thmbox}\setlength{\parskip}{6pt}
	\begin{corollaryc}
}{
	\end{corollaryc}
	\end{thmbox}
}
\newenvironment{example}{
	\begin{exbox}\setlength{\parskip}{6pt}
	\begin{examplec}
}{
	\end{examplec}
	\end{exbox}
}
\newenvironment{remark}{
	\begin{rmkbox}\setlength{\parskip}{6pt}
	\begin{remarkc}
}{
	\end{remarkc}
	\end{rmkbox}
}

%\renewcommand{\qedsymbol}{\color{main}$\square$} %square
%\renewcommand{\qedsymbol}{\color{main}$\blacksquare$} %filled square
\renewcommand{\qedsymbol}{\color{main}$\squoval$} %rounded square
\renewcommand{\proofname}{\color{main}\sffamily\textit{Proof}}
\newenvironment{solution}{\begin{proof}[\color{main}\sffamily\textit{Solution}]}{\end{proof}}