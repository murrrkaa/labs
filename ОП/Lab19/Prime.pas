PROGRAM Prime(INPUT, OUTPUT);
CONST
  MinNum = 2;
  MaxNum = 100;
VAR
  Sieve: SET OF MinNum..MaxNum;
  Min, I: INTEGER;
BEGIN
  Sieve := [MinNum..MaxNum];
  Min := MinNum;
  I := MinNum;
  WHILE Min <= MaxNum
  DO
    BEGIN
      I := Min;
      IF Min IN Sieve
      THEN
        BEGIN
          WHILE I <= MaxNum
          DO
            BEGIN
              Sieve := Sieve - [I];
              I := I + Min
            END;
          WRITE(Min, ' ')
        END;
     Min := Min + 1  
    END  
END.
