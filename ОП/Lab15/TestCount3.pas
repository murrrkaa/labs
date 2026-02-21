PROGRAM TestCount3(INPUT, OUTPUT);
USES Count3;
VAR
  Ch, Ch1, Ch2, Ch3, Overflow: CHAR;
BEGIN {TestCount3}
  Start;
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Bump(Overflow)
    END;
  IF Overflow = '1'
  THEN
    WRITELN('Переполнение счётчика')
  ELSE
    BEGIN
      Value(Ch1, Ch2, Ch3);
      WRITELN(Ch1, Ch2, Ch3)
    END
END. {Test Count3}
