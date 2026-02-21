PROGRAM ReverseLine(INPUT, OUTPUT);
PROCEDURE Reverse(VAR F: TEXT);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      Reverse(F);
      WRITE(OUTPUT, Ch)
    END
END;

BEGIN
  Reverse(INPUT);
  WRITELN(INPUT) 
END.


  
