PROGRAM Factorial(INPUT, OUTPUT);
VAR
  Num, Result: INTEGER;
  
PROCEDURE Factor(VAR Num: INTEGER; VAR Result: INTEGER);
VAR
  Temp: INTEGER;
BEGIN
  IF Num <= 1
  THEN
    Result := 1
  ELSE
    BEGIN
      Temp := Num - 1;
      Factor(Temp, Result);
      Result := Num * Result;
      IF Result >= MAXINT
      THEN
        Result := 0
    END
END;

BEGIN
  Result := 1;
  IF NOT EOLN
  THEN
    BEGIN
      READ(Num);
      Factor(Num, Result);
      WRITELN(Result)
    END
END.
