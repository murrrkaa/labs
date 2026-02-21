PROGRAM CalendarOrder(INPUT, OUTPUT); 
USES
  Mounth;
VAR
  M1, M2: Month;
BEGIN
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);
  {Сравнить М1 и М2 и вывести результаты}
  IF (M1 = NoMonth) OR (M2 = NoMonth)
  THEN
    WRITELN('Неверные данные')
  ELSE
    IF M1 = M2
    THEN
      BEGIN
        WRITE('Оба месяца ');
        WriteMonth(OUTPUT, M1);
        WRITELN;
      END
    {Сравнить и вывести результат}
    ELSE
      BEGIN
        WriteMonth(OUTPUT, M1);
        IF M1 < M2
        THEN
          WRITE(' предшествует ')
        ELSE
          WRITE(' cледует за ');
        WriteMonth(OUTPUT, M2);
        WRITELN
      END
END.
      
