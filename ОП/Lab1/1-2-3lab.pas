PROGRAM Palindrome(INPUT, OUTPUT);
VAR
  F2: TEXT;
BEGIN 
  ASSIGN(F2, 'Out.txt');
  REWRITE(F2);
  WRITE(F2, 'pppppppppppppppppp');
  WRITE('MADAM,');
  WRITELN(' I''M ADAM');
  CLOSE(F2)
END.
