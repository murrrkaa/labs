PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN {SarahRevere}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
  WHILE Looking = 'Y'
  DO
    BEGIN {Двигаем окно, проверяем конец данных}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      IF W4 = '#'
      THEN {Конец данных}
        Looking := 'N';
      BEGIN {Проверка окна для land}
        IF W1 = 'l'
        THEN
          IF W2 = 'a'
          THEN
            IF W3 = 'n'
            THEN
              IF W4 = 'd'
              THEN {'land' найдено}
                Looking := 'L'
      END; {Проверка окна для land}
      BEGIN {Проверка окна на sea}
        IF W2 = 's'
        THEN
          IF W3 = 'e'
          THEN
            IF W4 = 'a'
            THEN {'sea' найдено}
              Looking := 'S'
      END {Проверка окна для sea}
    END;
    WRITELN('Looking is', ' ', Looking)
END. {Sarah Revere}