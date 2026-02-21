PROGRAM CopyLine(INPUT, OUTPUT);
PROCEDURE RCopy(VAR F: TEXT);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      WRITE(OUTPUT, Ch);
      RCopy(F)
    END
  ELSE
    WRITELN
END;
BEGIN
  RCopy(INPUT) 
END.
