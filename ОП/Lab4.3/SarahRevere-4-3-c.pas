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
      END; {Проверка на land}
      BEGIN {Проверка окна для 'sea'}
        IF W1 = 's'
          THEN
            IF W2 = 'e'
            THEN
              IF W3 = 'a'
              THEN {'sea' найдено}
                Looking := 'S'
      END; {Проверка на sea}
        W1 := W2;
        W2 := W3;
        W3 := W4;
        READ(W4);
        WRITELN(W1, W2, W3, W4);
        IF Looking = 'Y'
        THEN
          Looking := 'N';

        IF W4 = '#'
        THEN {Конец данных}
          Looking := 'N';
    WRITELN('LOOKING IS', ' ', Looking)
    END;
  BEGIN {создать сообщение Sarah}
    IF Looking = 'L'
    THEN
        WRITELN('The British are coming by land.')
    ELSE
      IF Looking = 'S'
      THEN
        WRITELN('The British coming by sea.')
      ELSE
          WRITELN('Sarah didn''t say')   
   END {Создать сообщение Sarah}
END. {Sarah revere}