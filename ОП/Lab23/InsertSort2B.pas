PROGRAM InsertSort2(INPUT, OUTPUT);
TYPE 
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Key: CHAR
         END;
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;
  Found: BOOLEAN;
BEGIN {InsertSort2}
  FirstPtr := NIL;
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      NEW(NewPtr);
      READ(NewPtr^.Key);
      Prev := NIL;
      Curr := FirstPtr;
      Found := FALSE;
      WHILE (Curr <> NIL) AND NOT Found
      DO
      IF NewPtr^.Key > Curr^.Key
      THEN
        BEGIN
          Prev := Curr;
          Curr := Curr^.Next
        END
      ELSE
        Found := TRUE;
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
    END
END.  {InsertSort2}
