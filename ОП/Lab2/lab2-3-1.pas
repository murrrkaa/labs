PROGRAM Less(INPUT, OUTPUT);
VAR 
  Ch: CHAR;
BEGIN 
  READ(Ch);
  WRITE('Your offer without spaces:');
  WHILE Ch <> '#' 
  DO 
    BEGIN 
      IF Ch <> ' ' 
      THEN 
        WRITE(Ch); 
      READ(Ch) 
    END; 
  WRITELN 
END.