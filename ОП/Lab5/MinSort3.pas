PROGRAM MinSort3(INPUT, OUTPUT);
VAR 
  Ch1, Ch2, Ch3: CHAR;
BEGIN {MinSort3}
  READ(Ch1, Ch2, Ch3);
  IF Ch1 < Ch2
  THEN {Печатать минимум из Ch1, Ch3 в  OUTPUT, переместить Ch3 в Ch1,если необходимо}
    IF Ch1 < Ch3
    THEN
      BEGIN
        WRITE(Ch1);
        Ch1 := Ch3
      END
    ELSE
      WRITE(Ch3)
  ELSE {Печатать минимум из Ch2, Ch3 в  OUTPUT, переместить Ch3 в Ch2,если необходимо}
    IF Ch2 < Ch3
    THEN
      BEGIN
        WRITE(Ch2);
        Ch2 := Ch3
      END
    ELSE
      WRITE(Ch3)
END. {Minsort3}
