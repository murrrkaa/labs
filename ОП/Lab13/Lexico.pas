PROGRAM LexicoLine(INPUT, OUTPUT);
VAR 
  Ch, Res: CHAR;
  F1, F2: TEXT;
PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN{Lexico}
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1) AND NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF (Ch1 < Ch2)
      THEN 
        Result := '1'
      ELSE
        IF (Ch1 > Ch2)
        THEN
          Result := '2'
    END;
  IF (NOT EOLN(F1)) AND (EOLN(F2))
  THEN
    Result := '2';
  IF (NOT EOLN(F2)) AND (EOLN(F1))
  THEN
    Result := '1'  
END;{Lexico}

BEGIN
  REWRITE(F1);
  REWRITE(F2);
  IF NOT EOF(INPUT)
  THEN
    BEGIN
      WHILE NOT EOLN(INPUT)
      DO
        BEGIN
          READ(INPUT, Ch);
          WRITE(F1, Ch)
        END;
      READLN;
      WRITELN(F1);
      IF NOT EOF(INPUT)
      THEN
        WHILE NOT EOLN(INPUT)
        DO
          BEGIN
            READ(INPUT, Ch);
            WRITE(F2, Ch)
          END;
        WRITELN(F2);
    END;
  Lexico(F1, F2, Res);
  WRITELN(Res)
END.


