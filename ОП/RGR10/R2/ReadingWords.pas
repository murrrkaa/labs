UNIT ReadingWords;

INTERFACE

CONST
  MaxWordLen = 20;
  First = 1;
   
PROCEDURE CreateWord(VAR F: TEXT; VAR NewWord: STRING);
  
IMPLEMENTATION 

FUNCTION CheckUppercase(VAR Ch: CHAR): CHAR;
VAR
  F: TEXT;
  Ch1, Ch2: CHAR;
  Found: BOOLEAN;
BEGIN
  ASSIGN(F, 'Alphabet.txt');
  RESET(F);
  Found := FALSE;
  CheckUppercase := Ch;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch1);
      IF NOT EOLN(F)
      THEN
        BEGIN
          READ(F, Ch2);
          WHILE (NOT Found) AND (NOT EOF(F))
          DO
            BEGIN
              IF Ch = Ch1
              THEN
                BEGIN
                  CheckUppercase := Ch2;
                  Found := TRUE
                END
              ELSE
                BEGIN
                  READLN(F);
                  READ(F, Ch1);
                  READ(F, Ch2)
                END
            END;
          IF EOF(F)
          THEN
            IF Ch = Ch1
            THEN
              CheckUppercase := Ch2
        END
    END 
END;

FUNCTION CheckSpecialChar(VAR Ch: CHAR): BOOLEAN;
BEGIN
  IF (Ch = '-') OR (Ch = '''')
  THEN
    CheckSpecialChar := TRUE
  ELSE
    CheckSpecialChar := FALSE
END;

FUNCTION CheckChar(VAR Ch: CHAR): BOOLEAN;
BEGIN
  IF ((Ch >= 'a') AND (Ch <= 'z')) OR ((Ch >= 'à') AND (Ch <= 'ÿ')) OR (Ch = '¸')
  THEN
    CheckChar := TRUE
  ELSE
    CheckChar := FALSE
END;

PROCEDURE CreateWord(VAR F: TEXT; VAR NewWord: STRING);
VAR
  Ch, SpecialChar: CHAR;
  I: INTEGER;
BEGIN
  NewWord := '';
  I := 1;
  READ(F, Ch);
  Ch := CheckUppercase(Ch);
  IF (EOLN(F)) AND (CheckChar(Ch))
  THEN
    NewWord := NewWord + Ch;  
  WHILE (NOT EOLN(F)) AND (CheckChar(Ch)) AND (I <= MaxWordLen)
  DO
    BEGIN
      NewWord := NewWord + Ch;
      READ(F, Ch);
      I := I + 1;
      Ch := CheckUppercase(Ch);
      IF  CheckSpecialChar(Ch)
      THEN
        BEGIN
          SpecialChar := Ch;
          IF NOT EOLN(F)
          THEN
            BEGIN
              READ(F, Ch);
              Ch := CheckUppercase(Ch);
              IF CheckChar(Ch)
              THEN
                BEGIN
                  NewWord := NewWord + SpecialChar;
                  I := I + 1
                END
            END
        END;
      IF (EOLN(F)) AND (CheckChar(Ch))
      THEN
        NewWord := NewWord + Ch
    END
END;
 
BEGIN
  
END.
