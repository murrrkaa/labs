PROGRAM RemoveProbel(INPUT, OUTPUT);
VAR
  Ch, State: CHAR;
BEGIN
  Ch := ' ';
  State := 'B';
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      IF Ch <> ' '
      THEN
        BEGIN
          IF State = 'P'
          THEN
            WRITE(' ');
          WRITE(Ch);
          State := 'W'
        END
      ELSE
        IF State = 'W'
        THEN
          State := 'P'
    END
END.
