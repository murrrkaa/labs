PROGRAM BubbleSortMLB(INPUT, OUTPUT);
{Сортируем все строки INPUT по отдельности в OUTPUT}
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN{BubbleSortMLB}
  {Копируем INPUT в F1}
  REWRITE(F1);
  WHILE NOT EOF
  DO
    BEGIN
      WHILE NOT EOLN
      DO
        BEGIN
          READ(Ch);
          WRITE(F1, Ch)
        END;
      WRITELN(F1);
      READLN
    END;
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      {Копируем F1 в F2, проверяя отсортированность и переставляя первые соседние символы по порядку}
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      WHILE NOT EOF(F1)
      DO
        BEGIN
          WHILE NOT EOLN(F1)
          DO
            BEGIN
              READ(F1, Ch1);
              WHILE NOT EOLN(F1)
              DO
                BEGIN
                  READ(F1, Ch2);
                  {Выводим min(Ch1, Ch2) в F2, записывая отсортированные символы}
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
              WRITELN(F2, Ch1) {Выводим прследний символ в F2}
            END;
          READLN(F1)
        END;
      {Копируем F2 в F1}
      RESET(F2);
      REWRITE(F1);
      WHILE NOT EOF(F2)
      DO
        BEGIN
          WHILE NOT EOLN(F2)
          DO
            BEGIN
              READ(F2, Ch);
              WRITE(F1, Ch)
            END;
          WRITELN(F1);
          READLN(F2)
        END
    END;
  {Копируем F1 в OUTPUT}
  RESET(F1);
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(Ch)
        END;
      READLN(F1);
      WRITELN
    END
END. {BubbleSortMLB}
