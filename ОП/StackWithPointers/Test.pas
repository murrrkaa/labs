PROGRAM Test(INPUT, OUTPUT);
USES Stack;
VAR
  Ch: EltType;
BEGIN
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      Push(Ch);
      WRITE(Ch)
    END;
  WRITELN;
  WHILE NOT Empty
  DO
    BEGIN
      WRITE(Top);
      Pop(Ch)
    END
END.
