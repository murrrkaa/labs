UNIT WordStorage;

INTERFACE
 
CONST
  None = '';
  
PROCEDURE GetWord(I: INTEGER; VAR Count: INTEGER; VAR NewWord: STRING);
PROCEDURE PutWord(VAR NewWord: STRING);
FUNCTION GetWordsCount(): INTEGER;

IMPLEMENTATION

TYPE
  NodePtr = ^Node;
  Node = RECORD
           Key: STRING;
           Next: NodePtr;
           Count: INTEGER
         END;

VAR
  FirstPtr: NodePtr;
  CountWords: INTEGER;
  
FUNCTION GetWordsCount(): INTEGER;
BEGIN
  GetWordsCount := CountWords
END;

PROCEDURE ClearList;
VAR
  NewPtr, DelCurr: NodePtr;
BEGIN
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      DelCurr := NewPtr;
      NewPtr := NewPtr^.Next;
      DISPOSE(DelCurr)
    END
END;
  
PROCEDURE GetWord(I: INTEGER; VAR Count: INTEGER; VAR NewWord: STRING);
VAR
  NewPtr: NodePtr;
  IndexCurr: INTEGER;
BEGIN
  NewPtr := FirstPtr;
  IndexCurr := 1;
  WHILE (IndexCurr < I)
  DO
    BEGIN
      NewPtr := NewPtr^.Next;
      IndexCurr := IndexCurr + 1
    END;
  NewWord := NewPtr^.Key; 
  Count := NewPtr^.Count;
  IF I = GetWordsCount()
  THEN
    ClearList
END;

PROCEDURE InitCell(VAR NewPtr: NodePtr; VAR NewWord: STRING);
BEGIN
  NewPtr^.Key := NewWord;
  NewPtr^.Count := 1
END;

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

PROCEDURE Insert(VAR FirstPtr, NewPtr: NodePtr);
VAR
  Curr, Prev: NodePtr;
  Found, FoundEqual: BOOLEAN;
BEGIN
  Prev := NIL;
  Curr := FirstPtr;
  Found:= FALSE;
  FoundEqual := FALSE;
  WHILE (Curr <> NIL) AND (NOT Found) AND (NOT FoundEqual)
  DO
    BEGIN
      IF (CompareString(NewPtr^.Key, Curr^.Key) = 0)
      THEN
        BEGIN
          NewPtr^.Count := Curr^.Count + 1;
          NewPtr^.Next := Curr^.Next;
          DISPOSE(Curr);
          FoundEqual := TRUE
        END; 
      IF (CompareString(NewPtr^.Key, Curr^.Key) = 1)
      THEN
        BEGIN
          Prev := Curr;
          Curr := Curr^.Next
        END
      ELSE
        IF (CompareString(NewPtr^.Key, Curr^.Key) = 2)
        THEN
          Found := TRUE
    END;
  IF FoundEqual <> TRUE
  THEN
    BEGIN
      NewPtr^.Next := Curr;
      CountWords := CountWords + 1
    END;
    
  IF Prev = NIL 
  THEN
    FirstPtr := NewPtr
  ELSE
    Prev^.Next := NewPtr
END;

PROCEDURE PutWord(VAR NewWord: STRING);
VAR
  NewPtr: NodePtr;
BEGIN
  NEW(NewPtr);
  InitCell(NewPtr, NewWord);
  Insert(FirstPtr, NewPtr)
END;

BEGIN
  FirstPtr := NIL;
  CountWords := 0
END.
