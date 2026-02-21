PROGRAM SelectSort(INPUT, OUTPUT);
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  REWRITE(F1);
  WRITE(OUTPUT, 'INPUT DATA:');
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      WRITE(OUTPUT, Ch);
      READ(INPUT, Ch)
    END;
  WRITELN(OUTPUT);
  WRITELN(F1, '#');
  {WRITE(OUTPUT, 'SORTED DATA:');}
  RESET(F1);
  READ(F1, Ch);
  Ch := '#';
  WHILE Ch <> '#'
  DO { Ch <> С#Т и Ch1 Ц первый символ F1}
    BEGIN
      {¬ыбираем минимальный из F1 b копируем остаток F1 в F2}
      WRITE(OUTPUT, Min);
      { опируем F2 в F1}
      RESET(F1);
      READ(F1, Ch)
    END;
  WRITELN(OUTPUT)
END. {SelectSort}
