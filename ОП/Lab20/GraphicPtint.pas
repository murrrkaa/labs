PROGRAM Print(INPUT, OUTPUT);
CONST
  Size = 5 * 5;
  LetterM = [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
  LetterA = [3, 7, 9, 11, 12, 13, 14, 15, 16, 20, 21, 25];
  LetterC = [2, 3, 4, 6, 11, 16, 22, 23, 24];
  Colom = 5;
TYPE
  Matrix = SET OF 1..Size;
VAR
  Ch: CHAR;
FUNCTION GetMatrix(Ch: CHAR): Matrix;
BEGIN {GetMatrix}
  CASE Ch OF
   'M': GetMatrix := LetterM;
   'A': GetMatrix := LetterA; 
   'C': GetMatrix := LetterC
  ELSE
    GetMatrix := []  
  END  
END; {GetMatrix}
PROCEDURE PrintLetter;
VAR
  I: INTEGER;
BEGIN {PrintLetter}
  FOR I := 1 TO Size
  DO
    BEGIN
      IF I IN GetMatrix(Ch)
      THEN
        WRITE('*')
      ELSE
        WRITE(' ');
      IF I MOD Colom = 0
      THEN
        WRITELN
    END;
  WRITELN  
END; {PrintLetter}
BEGIN {Print}
  Ch := ' ';
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      IF GetMatrix(Ch) <> []
      THEN
        PrintLetter
      ELSE
        WRITELN('Неверно введённые данные')
    END
END. {Print}
