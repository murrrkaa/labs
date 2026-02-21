PROGRAM SortMonth(INPUT, OUTPUT);
USES
  MonthModule;
VAR
  M1, M2: Month;
BEGIN
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);
  IF (M1 = NoMonth) OR (M2 = NoMonth)
  THEN
    WRITELN('Неверные входные данные')
  ELSE
    IF M1 = M2
    THEN
      BEGIN
        WRITE('Оба месяца ');
        WriteMonth(OUTPUT, M1);
        WRITELN
      END
    ELSE
      BEGIN
        WriteMonth(OUTPUT, M1);
        IF M1 < M2
        THEN
          WRITE(' предшествует ')
        ELSE
          WRITE(' следует за ');
        WriteMonth(OUTPUT, M2);
        WRITELN
      END
END.
