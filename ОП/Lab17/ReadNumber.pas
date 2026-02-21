PROGRAM ReadingNumber(INPUT, OUTPUT);
VAR
  Result: INTEGER;
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      IF Ch = '0' THEN D := 0 ELSE
      IF Ch = '1' THEN D := 1 ELSE
      IF Ch = '2' THEN D := 2 ELSE
      IF Ch = '3' THEN D := 3 ELSE
      IF Ch = '4' THEN D := 4 ELSE
      IF Ch = '5' THEN D := 5 ELSE
      IF Ch = '6' THEN D := 6 ELSE
      IF Ch = '7' THEN D := 7 ELSE
      IF Ch = '8' THEN D := 8 ELSE
      IF Ch = '9' THEN D := 9 ELSE D := -1
    END
  ELSE
    D := -1  
END;
PROCEDURE ReadNumber(VAR F: TEXT; VAR Result: INTEGER);
VAR
  Digit: INTEGER;
BEGIN
  Digit := 0;
  Result := 0;
  WHILE (Digit <> -1) AND (Result <> -2)  
  DO
    BEGIN
      ReadDigit(INPUT, Digit);
      IF Digit <> -1
      THEN
        BEGIN
          IF Result <= ((MAXINT - Digit) DIV 10)
          THEN
            Result := Result * 10 + Digit
          ELSE
            Result := -2
        END
      ELSE
        Digit := -1
    END;
  IF Result = 0
  THEN
    Result := -2   
END; 
BEGIN
  ReadNumber(INPUT, Result);
  WRITELN(Result)  
END.
