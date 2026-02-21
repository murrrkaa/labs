PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1 ,W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN;
BEGIN
  {Инициализация}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := TRUE;
  Land := FALSE;
  Sea := FALSE;
  WHILE Looking AND NOT (Land OR Sea)
  DO
    BEGIN
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      Looking := (W4 <> '#');
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      Sea := (w2 = 's') AND (W3 = 'e') AND (W4 = 'a');
    END;
  IF Land
  THEN
    WRITE('The British are coming by land')
  ELSE
    IF Sea
    THEN
      WRITE('The British are coming by sea')
    ELSE
      WRITE('Sarah did not say')
END.
