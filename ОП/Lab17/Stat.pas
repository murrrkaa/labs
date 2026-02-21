PROGRAM Stat(INPUT, OUTPUT);
VAR
  Number: INTEGER;
  Count, Min, Max, Average, Sum, IntAverage, FloatAverage: INTEGER;
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
          IF (Result <= ((MAXINT - Digit) DIV 10))
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
    Result := -1   
END; 
BEGIN
  Count := 0;
  Min := MAXINT;
  Max := 0;
  Average := 0;
  IntAverage := 0;
  FloatAverage := 0;
  Sum := 0;
  Number := 0;
  WHILE (NOT EOLN(INPUT)) AND (Number >= 0)
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF Number >= 0
      THEN
        BEGIN
          IF (Count <= (MAXINT - 1))
          THEN
            Count := Count + 1;
          IF Number < Min
          THEN
            Min := Number;
          IF Number > Max
          THEN
            Max := Number;
          IF (Sum <= (MAXINT - Number))
          THEN
            Sum :=  Sum + Number
          ELSE
            Sum :=  -1  
        END
    END; 
  IF Number = -2
  THEN
    WRITELN('Ошибка входных данных')
  ELSE
    BEGIN
      IF Sum = -1
      THEN
        WRITELN('Min = ', Min, ' Max = ', Max, ' Not Average')
      ELSE
        BEGIN
          Average := (Sum * 100) DIV Count;
          IntAverage := Average DIV 100;
          FloatAverage := Average MOD 100;
          WRITELN('Min = ', Min, ' Max = ', Max, ' Count = ', Count, ' Average = ', IntAverage, ',', FloatAverage)
        END  
    END
END.
