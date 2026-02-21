PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4: CHAR;
PROCEDURE LookForFlag(VAR Looking, Land, Sea: BOOLEAN);
VAR
  Looking, Land, Sea: BOOLEAN; 
BEGIN
  Looking := (W4 <> '#');
  Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
  Sea := (w2 = 's') AND (W3 = 'e') AND (W4 = 'a') 
END;
PROCEDURE Messages(VAR Looking, Land, Sea: BOOLEAN);
BEGIN
  IF Land
  THEN
    WRITE('The British are coming by land')
  ELSE
    IF Sea
    THEN
      WRITE('The British are coming by sea')
    ELSE
      WRITE('Sarah did not say')
END;
BEGIN {SarahRevere}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  LookForFlag(Looking, Land, Sea);
  WHILE Looking AND NOT (Land OR Sea)
  DO
    BEGIN
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      LookForFlag(Looking, Land, Sea)
    END;
  Messages(Looking, Land, Sea)
END. {SarahRevere}
