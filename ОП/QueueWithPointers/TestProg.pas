PROGRAM Test(INPUT, OUTPUT);
USES Queue;
VAR
  Ch: EltType;
BEGIN
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch)
    END;
  WRITELN;
  HeadQ(Ch);
  WHILE Ch <> Empty
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  EmptyQ
END.
