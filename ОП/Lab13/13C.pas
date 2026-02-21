PROGRAM BubbleSort(INPUT, OUTPUT);
PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  READLN(InFile);
  WRITELN(OutFile)
END;
PROCEDURE CopyAndSwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
VAR Ch1, Ch2: CHAR;
BEGIN
  IF NOT EOF(F1)
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch2);
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;
      WRITELN(F2, Ch1)
    END
END;
PROCEDURE BubbleSort(VAR InFile, OutFile: TEXT);
VAR
  F1, F2: TEXT;
  Sorted: CHAR;
BEGIN
  REWRITE(F1);
  CopyFile(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      CopyAndSwap(F1, F2, Sorted);
      RESET(F2);
      REWRITE(F1);
      CopyFile(F2, F1);
    END;
  RESET(F1);
  CopyFile(F1, OUTPUT)
END;

BEGIN
  BubbleSort(INPUT, OUTPUT)  
END.
