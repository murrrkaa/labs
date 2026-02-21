Program DeleteSpace(INPUT, OUTPUT);
VAR
  Ch, Flag: CHAR;
BEGIN
  Flag := 'N';
  IF (NOT EOLN) AND (Flag <> 'Y')
  THEN
    BEGIN
      READ(Ch);
      WHILE Ch <> '#'
      DO
        BEGIN
          IF Ch = ' '
          THEN
            Flag := 'Y';
          IF Ch <> ' '
          THEN
            BEGIN
              WHILE Ch <> ' '
              DO
                BEGIN
                  WRITE(Ch);
                  READ(Ch)
                END;
              WRITE(Ch);
              Flag := 'Y'
            END;
          IF Flag = 'Y'
          THEN
            Flag := 'N';
          READ(Ch)
        END;
      Flag := 'Y'
    END;
  WRITELN
END.