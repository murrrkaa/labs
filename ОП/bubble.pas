PROGRAM BubbleSort(INPUT, OUTPUT);
TYPE 
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Key: CHAR
         END;
VAR
  Ch: CHAR;
  Sorted, Found: BOOLEAN;
  FirstPtr, NewPtr, Curr, Prev: NodePtr;
  
BEGIN { BubbleSort }
  FirstPtr := NIL;
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      NEW(NewPtr);
      READ(NewPtr^.Key);
      Prev := NIL;
      Curr := FirstPtr;
      NewPtr^.Next := Curr;
      IF Prev = NIL 
      THEN
        FirstPtr := NewPtr
      ELSE
        Prev^.Next := NewPtr
    END;
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(NewPtr^.Key);
      NewPtr := NewPtr^.Next
    END;  
  Sorted := FALSE;
  WHILE NOT Sorted 
  DO
    BEGIN
      Sorted := TRUE;
      Curr := FirstPtr;
      WHILE Curr^.Next <> NIL
      DO
        BEGIN
          IF Curr^.Key > Curr^.Next^.Key
          THEN
            BEGIN
              Sorted := FALSE;
              Ch := Curr^.Next^.Key;
              Curr^.Next^.Key := Curr^.Key;
              Curr^.Key := Ch
            END;
          Curr := Curr^.Next
        END
    END;
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(NewPtr^.Key);
      NewPtr := NewPtr^.Next
    END
END.
