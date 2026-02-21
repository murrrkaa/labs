PROGRAM CountProbel(INPUT, OUTPUT);
VAR
  Ch, x100, x10, x1: CHAR;
USES 
  Count3;
BEGIN
  Start;
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      IF Ch = ' '
      THEN
        Bump;
     END;
  Value(x100, x10, x1);
  WRITELN('Количество пробелов ', x100, x10, x1) 
END.
