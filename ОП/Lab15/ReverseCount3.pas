PROGRAM ReverseCount3(INPUT, OUTPUT);
USES Count3;
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN {ReverseCount3}
  Start;
  IF NOT EOLN
  THEN
    BEGIN
      READ(Ch1);
      IF NOT EOLN
      THEN
        BEGIN
          READ(Ch2);
          IF NOT EOLN
          THEN
            BEGIN
              READ(Ch3);
              IF ((Ch1 > Ch2) AND (Ch2 < Ch3)) OR ((Ch1 < Ch2) AND (Ch2 > Ch3))
              THEN
                Bump
            END
        END
    END;
  WHILE NOT EOLN
  DO
    BEGIN {Движение окна и проверка условия}
      Ch1 := Ch2;
      Ch2 := Ch3;
      READ(Ch3);
      IF ((Ch1 > Ch2) AND (Ch2 < Ch3)) OR ((Ch1 < Ch2) AND (Ch2 > Ch3))
      THEN
        Bump
    END;  {Движение окна и проверка условия}
  Value(Ch1, Ch2, Ch3);
  WRITELN(Ch1, Ch2, Ch3)
END. {ReverseCount3}
