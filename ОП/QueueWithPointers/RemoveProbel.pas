PROGRAM RemoveProbel(INPUT, OUTPUT);
USES Queue;
VAR 
  Ch: EltType;

PROCEDURE RemoveExtraBlank;
VAR
  Ch: EltType;
  Blank, LineEnd: CHAR;
BEGIN
  Blank := ' ';
  LineEnd := '$';
  AddQ(LineEnd);
  HeadQ(Ch);
  WHILE Ch <> LineEnd
  DO
    BEGIN
      WHILE (Ch <> Blank) AND (Ch <> LineEnd)
      DO
        BEGIN
          AddQ(Ch);
          DelQ;
          HeadQ(Ch)
        END;
      WHILE Ch = Blank
      DO
        BEGIN
          DelQ;
          HeadQ(Ch)
        END;
      IF Ch <> LineEnd
      THEN
        AddQ(Blank)
    END;
  DelQ
END;

BEGIN
  WRITE('Вход: ');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      AddQ(Ch);
      WRITE(Ch)
    END;
  WRITELN;
  RemoveExtraBlank;
  WRITE('Выход: ');
  HeadQ(Ch);
  WHILE Ch <> Empty
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN
END.
