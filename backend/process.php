<?php
  file_put_contents("logs.log" , json_encode($_POST) . '\n', FILE_APPEND);
  if(!isset($_POST["content"])) die('{ "status": "Invalid request"}');
  $json = $_POST["content"];
  $taskObject = json_decode($json);
  $pdfID = uniqid( "" , true);
  file_put_contents("in/zad0.in" , $taskObject->tests[0][0]);
  file_put_contents("in/zad0b.in" , $taskObject->tests[1][0]);
  file_put_contents("in/zad0c.in" , $taskObject->tests[2][0]);
  file_put_contents("out/zad0.out" , $taskObject->tests[0][1]);
  file_put_contents("out/zad0b.out" , $taskObject->tests[1][1]);
  file_put_contents("out/zad0c.out" , $taskObject->tests[2][1]);

  $texFile = "\documentclass[zad]{soigstyl}

  \pagestyle{fancy}
  \konkurs{" . $taskObject->contest . "}
  \day{" . $taskObject->day . "}
  \date{" . $taskObject->date . "}
  \setlogo{oiglogo}
  \setstopka{stopka_bw}
  \\title{\mbox{" . $taskObject->title . "}}
  \id{zad}
  \RAM{" . $taskObject->ram . "}

  \begin{document}

  \begin{tasktext}
      \\noindent
      " . $taskObject->content . "

    \section{Wejście}
    " . $taskObject->input . "

    \section{Wyjście}
    " . $taskObject->output ."

    \oigprzyklady
  \\end{tasktext}
  \\end{document}";

  file_put_contents("doc/zad.tex" , $texFile);
  //echo shell_exec("bash gen.sh ".$pdfID);
  exec("cd doc; pdflatex -jobname ".$pdfID." zad.tex");
  exec("cp doc/".$pdfID.".pdf pdfs");
  exec("rm doc/".$pdfID.".*");
  echo '{ "status": "OK", "link": "http://lokinado.ct8.pl/OI-styleTaskGenerator/pdfs/'.$pdfID.'.pdf"}';
?>
