PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN {SarahRevere}
  {инициализация W1,W2,W3,W4,Looking}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
  WHILE Looking = 'Y'
  DO
    BEGIN
      BEGIN {Проверка окна для 'land'}
        IF W1 = 'l'
        THEN
          IF W2 = 'a'
          THEN
            IF W3 = 'n'
            THEN
              IF W4 = 'd'          
              THEN {'land' найдено}
                Looking := 'L';
                WRITELN('The British are coming by land');
      END; {Проверка на land}
      BEGIN {Проверка окна для 'sea'}
        IF W1 = 's'
          THEN
            IF W2 = 'e'
            THEN
              IF W3 = 'a'
              THEN {'sea' найдено}
                Looking := 'S';
                WRITELN('The British are coming by sea'):
      END; {Проверка на sea}
      BEGIN { Двигать окно, проверять конец данных}
        W1 := W2;
        W2 := W3;
        W3 := W4;
        READ(W4);
        WRITELN(W1, W2, W3, W4);
        IF W4 = '#'
        THEN {Конец данных}
          Looking := 'N';
          WRITELN('Sarah did not say');
      END; {Двигать окно, проверять конец данных}
    WRITELN('LOOKING IS', ' ', Looking);
    END;  
END. {Sarah revere}