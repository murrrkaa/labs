PROGRAM Format(INPUT, OUTPUT);
VAR
  Ch, Flag, FlagE, FlagB: CHAR;
BEGIN
  Flag := 'N';
  FlagE := 'N';
  FlagB := 'N';
  Ch := ' ';
  WHILE (Ch <> '.') AND (NOT EOLN)
  DO
    WHILE (Flag <> 'Y') AND (FlagE = 'N')
    DO
      BEGIN
        READ(Ch);
        IF (Ch = 'B') AND (FlagB <> 'Y')
        THEN
          BEGIN
            READ(Ch);
            IF Ch = 'E'
            THEN
              BEGIN
                READ(Ch);
                IF Ch = 'G'
                THEN
                  BEGIN
                    READ(Ch);
                    IF Ch = 'I'
                    THEN
                      BEGIN 
                        READ(Ch);
                        IF Ch = 'N'
                        THEN
                          BEGIN
                            WRITE('BEGIN');
                            WRITELN;
                            WRITE('  ');
                            Flag := 'Y';
                            FlagB := 'Y'
                          END  
                      END
                  END       
              END
          END;
        IF Ch = ' '
        THEN
          Flag := 'Y';
        IF Ch = ';'
        THEN
          BEGIN
            WRITE(Ch);
            READ(Ch);
            WHILE Ch = ';'
            DO
              BEGIN
                WRITELN;
                WRITE('  ');
                WRITE(Ch);
                READ(Ch)
              END;
            IF Ch = ' '
            THEN
              BEGIN
                READ(Ch);
                WHILE Ch = ' '
                DO
                  READ(Ch);
                IF Ch = ';'
                THEN
                  BEGIN
                    WRITELN;
                    WRITE('  ');
                    WRITE(Ch);
                    WRITELN;
                    WRITE('  ');
                    Flag := 'Y'
                  END;
                IF (Ch <> ' ') AND (Ch <> 'E') AND (Flag <> 'Y')
                THEN
                  BEGIN
                    WRITELN;
                    WRITE('  ');
                    WRITE(Ch);
                    Flag := 'Y'
                  END
              END
            ELSE
              IF Ch <> 'E'
              THEN
                BEGIN
                  WRITELN;
                  WRITE('  ');
                  WRITE(Ch);
                  Flag := 'Y'
                END
          END;
        IF Ch = '('
        THEN
          BEGIN
            WRITE(Ch);
            READ(Ch);
            WHILE (Ch <> ')') AND (Ch <> '.')
            DO
              BEGIN
                IF Ch = ','
                THEN
                  BEGIN
                    WRITE(Ch, ' ');
                    READ(Ch)
                  END;
                IF Ch = '.'
                THEN
                  BEGIN
                    FlagE := 'Y';
                    Flag := 'Y'
                  END;
                IF Ch = ' '
                THEN
                  READ(Ch)
                ELSE
                  BEGIN
                    WRITE(Ch);
                    READ(Ch);
                    Flag := 'Y'
                  END
              END;
            IF Ch = '.'
            THEN
              FlagE := 'Y';
            Flag := 'Y'
          END;
        IF Ch = ','
        THEN
          BEGIN
            WRITE(Ch);
            WRITE(' ');
            Flag := 'Y'
          END;
        IF Ch = ')'
        THEN
          BEGIN
            WRITE(Ch);
            Flag := 'Y'
          END;  
        IF (Ch = 'E') AND (FlagE <> 'Y')
        THEN
          BEGIN
            READ(Ch);
            IF Ch = 'N'
            THEN
              BEGIN
                READ(Ch);
                IF Ch ='D'
                THEN
                  BEGIN
                    READ(Ch);
                    WHILE Ch = ' '
                    DO
                      READ(Ch);
                    IF Ch = '.'
                    THEN
                      BEGIN
                        WRITELN;
                        WRITE('END.');
                        FlagE := 'Y';
                        Flag := 'Y'
                      END
                    ELSE
                      BEGIN
                        WRITE('END', Ch);
                        Flag := 'Y'
                      END
                  END
              END
            ELSE
              IF Ch = ' '
              THEN
                BEGIN
                  WRITE('E');
                  Flag := 'Y'
                END
              ELSE
                BEGIN
                  WRITE('E', Ch);
                  Flag := 'Y'
                END
          END;
        IF Flag = 'N'
        THEN
          WRITE(Ch)
        ELSE
          Flag := 'N'
    END           
END.          

