%
% Styl do "produkcji" zadań na zawody drużynowe OIG 
% i inych konkursów na SOIG
%
% opracowany w oparciu o SINOL w wersji 1.9.3
%mocno odchudzony, aby łatwiej było utrzymać
%
% \history{1.0.0}{Adam Dzedzej}{2011/10/31}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\stylVersion{1.0.0}
\ProvidesClass{soigstyl}[2011/10/31 Olimpiada Informatyczna Gimnazjalistów \stylVersion]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{epsf}
\RequirePackage{graphicx}
\RequirePackage{ifpdf}
\RequirePackage{fancyhdr}
\RequirePackage{amssymb}
\RequirePackage[utf8]{inputenc}
\RequirePackage{verbatim}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zmienne logiczne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdatedefed \datedefedfalse  % czy podano date
\newif\ifetapdefed \etapdefedfalse  % czy podano etap
\newif\ifkonkursdefed \konkursdefedfalse  % czy podano konkurs
\newif\ifdaydefed \daydefedfalse  % czy podano dzien
\newif\ifRAMdefed \RAMdefedfalse  % czy podano dostpn pami
\newif\iftimedefed \timedefedfalse % czy podano czas dzialania
\newif\ifDocVersiondefed % czy zdefiniowano wersje dokumentu
\DocVersiondefedfalse    % (domylnie nie)
\newif\ifoigdefed \oigdefedfalse  % czy podano, że konkurs to OIG
\newif\iflogodefed \logodefedfalse  % czy zmieniono logo
\newif\ifstopkadefed \stopkadefedfalse  % czy mamy plik ze stopka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozwijajace \uppercase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ucase#1{\expandafter\uppercase\expandafter{#1}}
\def\lcase#1{\expandafter\lowercase\expandafter{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% logo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\LOGO{%
  \leavevmode
  \hbox{%
    \vbox to 0pt{%
      \vss
      \hbox{%
        \includegraphics[height=2cm]{\logoFile}
      }%
    }%
  }%
}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \ifundef{<makro>}{<jesli tak>}{<jesli nie>}
% --- wykonuje jeden z blokow, w zaleznosci od tego,
%     czy makro jest zdefiniowane
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ifundef#1#2#3{
  \expandafter
  \ifx\csname #1\endcsname\relax
    #2
  \else
    #3
  \fi
}
\def\ifeq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb
    #3
  \fi
}
\def\ifneq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb\else
    #3
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \concludedecls --- uruchamiane po przeczytaniu deklaracji
% \concludetext --- uruchamiane po przeczytaniu tekstu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\concludedecls}{}
\newcommand{\concludetext}{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numer rozdzialu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\oigSectionNumber \oigSectionNumber=0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footnote-ki indeksowane symbolami, a nie liczbami. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\thefootnote{\fnsymbol{footnote}} 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\let\oldpagestyle\pagestyle
\def\oigPageStyle{fancy}
\renewcommand{\pagestyle}[1]{%
  \gdef\oigPageStyle{#1}%
  \oldpagestyle{#1}
}


\newcommand{\history}[3]{%

  \edef\oigHistory{\noindent $\bullet$\ v.\,#3: #1, #2\par\oigHistory}%
  \gdef\oigDocVersion{#3}%
  \DocVersiondefedtrue%
}

\renewcommand{\date}[1]{%
  \def\oigDate{#1}%
  \global\datedefedtrue
}

\newcommand{\etap}[1]{%
  \def\oigEtap{#1}%
  \global\etapdefedtrue
}

\newcommand{\konkurs}[1]{%
  \def\oigKonkurs{#1}%
  \global\konkursdefedtrue
}

\renewcommand{\day}[1]{%
  \newcommand{\oigDay}{#1}%
  \global\daydefedtrue
}

\newcommand{\RAM}[1]{
  \newcommand{\oigRAM}{#1}%
  \global\RAMdefedtrue
}

\newcommand{\Time}[1]{
  \newcommand{\oigTime}{#1\,s}%
  \global\timedefedtrue
}

\newcommand{\logoFile}{talentlogo}
\newcommand{\setlogo}[1]{
  \renewcommand{\logoFile}{#1}%
  \global\logodefedtrue
}

\newcommand{\stopkaFile}{brak}
\newcommand{\setstopka}[1]{
  \renewcommand{\stopkaFile}{#1}%
  \global\stopkadefedtrue
}


%\def\oigSolNameC{.c}
%\def\oigSolNameCPP{.cpp}
%\def\oigSolNamePAS{.pas}


\def\oigEtapText{}
\def\oigKonkursText{}
\def\oigDayText{dzień}
\def\oigRAMText{Dostępna pamięć}
\def\oigTimeText{Maksymalny czas działania}
\def\oigOprText{Szkic rozwiązania}

\newcommand{\makestopki}[0]{
  %% definiowanie stopek dla stylu fancy
  \lfoot{\ifDocVersiondefed v.\,\oigDocVersion \fi}%
  \cfoot{~\\
  \rule{168mm}{0.4pt} }
  \ifstopkadefed
  	\cfoot{~\\%
  	%\thepage/\pageref{koniec} \\
  	     	 \rule{168mm}{0.4pt}\\~\\
  	     	 Człowiek -- najlepsza inwestycja
   		  	  \includegraphics[width=168mm]{\stopkaFile}
  	}%
  \fi
  \rfoot{\oigTitle}%
}



\def\oigCatNameZad{zad}
\DeclareOption{zad}{%
  \def\oigcat{zad}
  \def\xoigcat{\oigTitleZadanie}
  \renewcommand{\title}[1]{%
    \def\oigTitle{#1}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
  }


  \def\oigTestIn{../in}
  
  \def\oigTestOut{../out}
  
%przykłady dla OIG

	\newcommand{\inputexample}[1]{
			\vspace{-5mm}
			\verbatiminput{#1}
			\vspace{-5mm}
	}
	\newcommand{\oigprzyklady}{%
	\section{Przykłady}%
	%
	\begin{tabular}{|p{0.3\textwidth}|p{0.3\textwidth}|p{0.3\textwidth}|}%
	\hline
     \vspace{1mm}{\bf Wejście:} &   \vspace{1mm}{\bf Wejście:}&   \vspace{1mm}{\bf Wejście:}\\
       \vspace{4mm}\inputexample{../in/\ID0.in}\vspace{2mm} %
       %ADz:nie wiem czemu pierwsza kolumna ustawia się domyślnie inaczej niż pozostałe
    &  \inputexample{\oigTestIn/\ID0b.in}\vspace{-3mm}
    &  \inputexample{../in/\ID0c.in}\vspace{-3mm}\\
	{\bf Wyjście: }& {\bf Wyjście: }& {\bf Wyjście: }\\
	     \inputexample{../out/\ID0.out}
    &    \inputexample{../out/\ID0b.out}
    &    \inputexample{../out/\ID0c.out}\\
    \hline
    \end{tabular}
	}%oigprzyklady


	\newcommand{\inputtest}[1]{
		\begin{minipage}{5cm}
			\vspace{3mm}
			\verbatiminput{#1}
			\vspace{-1mm}
		\end{minipage}
	}
	\newcommand{\outputbox}{
		\mbox{\begin{minipage}{7cm}\hspace{7cm}\end{minipage}}
	}


	\newcommand{\KartaOdp}{
	\begin{center}
	\LARGE \bf  KARTA ODPOWIEDZI
	\end{center}

	\begin{tabular}{|c|c|c|}
	\hline
	Nazwa testu & Wejście & Wyjście\\
	\hline
	\ID1.in &  \inputtest{../in/\ID1.in}  & \outputbox \\
	\hline
	\ID2.in &  \inputtest{../in/\ID2.in}  & \outputbox \\
	\hline
	\ID3.in &  \inputtest{../in/\ID3.in}  & \outputbox \\
	\hline
	\ID4.in &  \inputtest{../in/\ID4.in}  & \outputbox \\
	\hline
	\ID5.in &  \inputtest{../in/\ID5.in}  & \outputbox \\
	\hline
	\end{tabular}
	}%KartaOdp

  \renewcommand{\concludedecls}{%
    \def\infile{{\ttfamily \lcase{\ID}.in}}%
    \def\outfile{{\ttfamily \lcase{\ID}.out}}%
    \def\oigIdSignature{\ID/\oigSignature}%
    \let\oldsection\section%
    \renewcommand{\section}[1]{%
      \def\@tmparg{##1}%
      \oldsection*{##1}%
      \advance\oigSectionNumber+1%
    }%
  }%

  \renewcommand{\concludetext}{
    \ifnum\oigSectionNumber=5\else
    \fi
  }
}% koniec opcji zad

\DeclareOption{opr}{%
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
  }
  \renewcommand{\title}[1]{%
    \def\oigTitle{#1}%
  }

\newenvironment{oprtext}{%
  \makestopki 
  \concludedecls%
  {%
    \leftline{%
      \begin{minipage}[t]{0.8\textwidth}
        \sffamily\bfseries%
        \LARGE%
        \oigOprText\ %
        \oigTitle%
      \end{minipage}
      \begin{minipage}[t]{0.1\textwidth}
        \sffamily\bfseries%
        \large%
        \center
      \end{minipage}
    }%
  }%


  \hbox to\hsize{\hfill\LOGO}\medskip   %
  \hrule
  \smallskip
    \hbox to\hsize{%
     \bf
     \def\@tempempty{}%
      %% Konkurs pokazuje sie tylko gdy jest niepusty
      \ifkonkursdefed%
        \ifx\oigKonkurs\@tempempty,\ %
        \else%
          \oigKonkursText%
          \oigKonkurs,\ %
        \fi%
      \fi%
      %% Etap pokazuje sie tylko gdy jest niepusty
      \ifetapdefed%
        \ifx\oigEtap\@tempempty%
        \else%
         \oigEtapText\ %
         \oigEtap%
        \fi%
      \fi%
      %% Dzien pokazuje sie tylko gdy jest niepusty
      \ifdaydefed%
      \ifx\oigDay\@tempempty%
        \else,
          \oigDayText\ %
          \oigDay
        \fi%
      \fi.%  
     %% Dostepna pamiec -- pokazuje sie tylko gdy
     %% nie jest pusta i jest zdefiniowana
     \ifRAMdefed%
       	\ifx\oigRAM\@tempempty%
       	\else%
      		\oigRAMText:\
       		\oigRAM\,MB. 
      	\fi%
  	 \else\fi%
  \hfill{\it\oigDate}
  }
  \hrule
     \bigskip
  \noindent
  \ignorespacesafterend
}{%
  \concludetext
  \label{koniec}%
}%oprtext



} %opr



\newenvironment{tasktext}{%
  \makestopki
  \concludedecls%
  {%
    \leftline{%
      \begin{minipage}[t]{0.8\textwidth}
        \sffamily\bfseries%
        \LARGE%
        \oigTitle
      \end{minipage}
      \begin{minipage}[t]{0.1\textwidth}
        \sffamily\bfseries%
        \large%
        \center
      \end{minipage}
    }%
  }%

  \hbox to\hsize{\hfill\LOGO}\medskip   %
  \hrule
  \smallskip
    \hbox to\hsize{%
     \bf
     \def\@tempempty{}%
      %% Konkurs pokazuje sie tylko gdy jest niepusty
      \ifkonkursdefed%
        \ifx\oigKonkurs\@tempempty,\ %
        \else%
          \oigKonkursText%
          \oigKonkurs,\ %
        \fi%
      \fi%
      %% Etap pokazuje sie tylko gdy jest niepusty
      \ifetapdefed%
        \ifx\oigEtap\@tempempty%
        \else%
         \oigEtapText\ %
         \oigEtap%
        \fi%
      \fi%
      %% Dzien pokazuje sie tylko gdy jest niepusty
      \ifdaydefed%
      \ifx\oigDay\@tempempty.
        \else,
          \oigDayText\ %
          \oigDay
        \fi%
      \fi%
      .
     %% Dostepna pamiec -- pokazuje sie tylko gdy
     %% nie jest pusta i jest zdefiniowana
     \ifRAMdefed%
       	\ifx\oigRAM\@tempempty%
       	\else%
      		\oigRAMText:\
       		\oigRAM\,MB. 
      	\fi%
  	 \else\fi%
  \hfill{\it\oigDate}
  }
  \hrule
  \bigskip
  \noindent
  \ignorespacesafterend
}{%
  \concludetext
  \label{koniec}%
}%tasktext




\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\PassOptionsToClass{a4paper}{article}
\LoadClass{article}
\RequirePackage{polski}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\textwidth}{168mm}
\setlength{\textheight}{223mm} %to już się robi mało, ale stopka chce dużo miejsca brać ADz
\setlength{\oddsidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\hoffset}{-4mm} % this means 1in-15mm
\setlength{\voffset}{-20mm} % this means 1in-15mm
\setlength{\topmargin}{0pt}
\renewcommand{\headrulewidth}{0pt}
