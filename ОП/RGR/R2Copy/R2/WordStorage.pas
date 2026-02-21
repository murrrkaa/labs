UNIT WordStorage;

INTERFACE

CONST
  None = '';
  
TYPE
  Tree = ^Node;
  Node = RECORD
           Word: STRING;
           RLink, LLink: Tree;
           Counter: INTEGER
         END;
  

PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
FUNCTION CompareString(VAR StrOne, StrTwo: STRING): INTEGER;
PROCEDURE DestroyTree(VAR Root: Tree);

IMPLEMENTATION

FUNCTION CheckException(VAR Ch1, Ch2: CHAR): INTEGER;
BEGIN
  IF (Ch1 = '¸') AND ((Ch2 >= 'à') AND (Ch2 <= 'å'))
  THEN
    CheckException := 1
  ELSE
    IF (Ch1 = '¸') AND ((Ch2 >= 'æ') AND (Ch2 <= 'ÿ'))
    THEN
      CheckException := 2;
      
  IF (Ch2 = '¸') AND ((Ch1 >= 'à') AND (Ch1 <= 'å'))
  THEN
    CheckException := 2
  ELSE
    IF (Ch2 = '¸') AND ((Ch1 >= 'æ') AND (Ch1 <= 'ÿ'))
    THEN
      CheckException := 1;
      
  IF (Ch1 = '¸') AND ((Ch2 >= 'a') AND (Ch2 <= 'z'))
  THEN
    CheckException := 1;
    
  IF (Ch2 = '¸') AND ((Ch1 >= 'a') AND (Ch1 <= 'z'))
  THEN
    CheckException := 2 
END;

FUNCTION CheckStrByLength(VAR StrOne, StrTwo: STRING): INTEGER;
BEGIN
  IF LENGTH(StrOne) > LENGTH(StrTwo)
  THEN
    CheckStrByLength := 1
  ELSE
    IF LENGTH(StrOne) < LENGTH(StrTwo)
    THEN
      CheckStrByLength := 2
    ELSE
      CheckStrByLength := 0
END;

FUNCTION CompareString(VAR StrOne, StrTwo: STRING): INTEGER;
VAR
  I: INTEGER;
  Found: BOOLEAN;
BEGIN
  I := 1;
  Found := FALSE;
  WHILE ((I <= LENGTH(StrOne)) AND (I <= LENGTH(StrTwo))) AND (NOT Found)
  DO
    BEGIN 
      IF (StrOne[I] < StrTwo[I]) 
      THEN
        BEGIN
          CompareString := 2;
          Found := TRUE
        END
      ELSE
        IF (StrOne[I] > StrTwo[I])
        THEN
          BEGIN
            CompareString := 1;
            Found := TRUE
          END; 
      IF ((StrOne[I] = '¸') OR (StrTwo[I] = '¸')) AND (StrOne[I] <> StrTwo[I])
      THEN
        BEGIN
          CompareString := CheckException(StrOne[I], StrTwo[I]);
          Found := TRUE
        END;
      I := I + 1
    END;
  IF NOT Found
  THEN
    CompareString := CheckStrByLength(StrOne, StrTwo)  
END;


PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL;
      Ptr^.Word := Data;
      Ptr^.Counter := 1
    END
  ELSE
    IF CompareString(Ptr^.Word, Data) = 1
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      IF CompareString(Ptr^.Word, Data) = 2
      THEN
        Insert(Ptr^.RLink, Data)
      ELSE
        Ptr^.Counter := Ptr^.Counter + 1; 
END;

PROCEDURE DestroyTree(VAR Root: Tree);
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      DestroyTree(Root^.LLink);
      DestroyTree(Root^.RLink);
      DISPOSE(Root);
      Root := NIL
    END
END;

BEGIN
END.


