\pdfminorversion=4 % force pdf 1.4 output; http://tex.stackexchange.com/questions/95973/is-pdftex-1-40-13-outputting-malformed-pdfs

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fund}

\LoadClass[11pt]{book}
% Note that 11 pt does work with pdflatex, even though 11 pt is not one of the sizes
% of CM. I don't know whether it scales up 10 pt or scales down 12 pt, but anyway, it
% works.
%====================== counters =====================================================
\newcounter{dqctr}[subsection]
\newcounter{egctr}[chapter]
\newcounter{scctr}[chapter]
\newcounter{hwctr}[chapter]
%====================== packages =====================================================
\RequirePackage{amsmath}
\def\maketag@@@#1{\hbox{\m@th#1}} % workaround for bug in amsmath; see http://tex.stackexchange.com/a/155719/6853
\RequirePackage{url,learn-cmd-syntax,enumerate,fancyvrb}
% enumerate is for lc roman numerals, which I sometimes want so items don't look like equation numbers
% fancyvrb is for code listings
\StartSaveCommands % for learn-cmd-syntax
%====================== pull in sub-packages =====================================================
\RequirePackage{lmlanguage,lmlayout,lmcommon,lmfigs,lmenvironments}
%=====================================================================================
% In DP, we use italics for figref, but in LM that would look too much like an algebra
% symbol, so no italics.
\newcommand{\formatfigref}[1]{#1}

% titlesec stuff:
\titleformat{\chapter}[display]
    {\normalfont\huge\bfseries\sffamily\sansmath\raggedright}{Chapter \thechapter}{0mm}
    {\Huge}
\newcommand{\normalsectiontitleformat}{
  \titleformat{\section}
    {\normalfont\Large\bfseries\sffamily\sansmath\raggedright}{\showsecnum{\thesection}}{0.6em}{}
}
\normalsectiontitleformat
\titleformat{\subsection}
  {\normalfont\normalsize\bfseries\sffamily\raggedright\protect\sansmath}{\lmserifmath\showsecnum{\thesubsection}}{0.6em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\slshape\raggedright}{\thesubsubsection}{1em}{}
%-------------------- sections and subsections -------------------------
% (chapter stuff is in lmfigs.cls, since it contains a lot of stuff for figures)
  \newcommand{\mysection}[2][4]{\pagebreak[#1]%
	\section{#2}\myeqnspacing%
        \setcounter{dqctr}{0}% gets done automatically for subsections, but I need to do it explicitly for sections that have no subsections
  }
  \newcommand{\myoptionalsection}[2][4]{\pagebreak[#1]%
	\section{$\star$ #2}\myeqnspacing}
  \newcommand{\mysubsection}[2][3]{\pagebreak[#1]\subsection{#2}}
  \newcommand{\mysubsectionnotoc}[2][3]{\pagebreak[#1]\subsection*{#2}}

\newcommand{\emt}{\mathcal{F}}%electromagnetic field tensor

\StopSaveCommands % for learn-cmd-syntax
\WriteSaveCommands  % for learn-cmd-syntax
%-------------
% http://tex.stackexchange.com/a/22101/6853
    \newsavebox\myboxA
    \newsavebox\myboxB
    \newlength\mylenA

    \newcommand*\xoverline[2][0.75]{%
        \sbox{\myboxA}{$\m@th#2$}%
        \setbox\myboxB\null% Phantom box
        \ht\myboxB=\ht\myboxA%
        \dp\myboxB=\dp\myboxA%
        \wd\myboxB=#1\wd\myboxA% Scale phantom
        \sbox\myboxB{$\m@th\overline{\copy\myboxB}$}%  Overlined phantom
        \setlength\mylenA{\the\wd\myboxA}%   calc width diff
        \addtolength\mylenA{-\the\wd\myboxB}%
        \ifdim\wd\myboxB<\wd\myboxA%
           \rlap{\hskip 0.5\mylenA\usebox\myboxB}{\usebox\myboxA}%
        \else
            \hskip -0.5\mylenA\rlap{\usebox\myboxA}{\hskip 0.5\mylenA\usebox\myboxB}%
        \fi}
%============================= homework ==================================================
\newcommand{\givecredit}[1]{\hwaddtrailingstuff{\footnotesize{[#1]}}}
\newcommand{\thompson}{\givecredit{Thompson, 1919}}
\newcommand{\granville}{\hwaddtrailingstuff{\footnotesize{[Granville, 1911]}}}
%============
% This is analogous to the lessimportant environment from lmenvironments.sty.
\newenvironment{theorem}[1][Theorem]%      
        {%
          \setlength{\saveleftskip}{\leftskip}%
          \addtolength{\leftskip}{10mm}%
          \noindent\ifthenelse{\equal{#1}{}}{}{\textbf{#1}\\*}%
        }{%
          \par  \setlength{\leftskip}{\saveleftskip} \par%
        }
\newcommand{\myqed}{$\square$}
\newenvironment{hwinstructions}%      
        {%
          \itshape
        }{%
        }
%============================= code listings ==================================================
\newcounter{listingline}
\setcounter{listingline}{1}
\newcommand{\formatline}[1]{{\footnotesize #1\ }}
% ii = input line
% nn = numbered input line
% cc = continuation of an input line
% oo = output line
\newcommand{\ii}{\ }
\newcommand{\nn}{\formatline{\arabic{listingline}}\addtocounter{listingline}{1}}
\newcommand{\cc}{\formatline{\ \ \ \ \ \ }}
\newcommand{\oo}[1]{\formatline{\ \ \ \ }\textit{#1}}
\DefineVerbatimEnvironment{Code}{Verbatim}{commandchars=\\\{\},gobble=2}
\newcommand{\restartLineNumbers}{\setcounter{listingline}{1}}
\newcommand{\startcodeeg}{\nolinebreak[4]\vspace{-7mm}\nolinebreak[4]}
\newcommand{\finishcodeeg}{\vspace{-2mm}}
