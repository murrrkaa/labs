PROGRAM BubbleSort(INPUT, OUTPUT);
TYPE
  EltType = CHAR;
  Node = ^Bubble;
  Bubble = RECORD
             Ch: EltType;
             Next: Node
           END;
VAR
  Sorted: BOOLEAN;
  First, Prev, Curr, NewNode: Node;
  Temp: CHAR;
BEGIN
  First := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      NEW(NewNode);
      READ(NewNode^.Ch);
      IF First = NIL
      THEN
        First := NewNode
      ELSE
        BEGIN
          Curr := First;
          WHILE Curr^.Next <> NIL
          DO
            Curr := Curr^.Next;
          Curr^.Next := NewNode
        END
    END;
  
  Sorted := FALSE;
  WHILE NOT Sorted
  DO
    BEGIN
      Sorted := TRUE;
      Curr := First;
      WHILE Curr^.Next <> NIL
      DO
        BEGIN
          IF Curr^.Ch > Curr^.Next^.Ch
          THEN
            BEGIN
              Sorted := FALSE;
              Temp := Curr^.Ch;
              Curr^.Ch := Curr^.Next^.Ch;
              Curr^.Next^.Ch := Temp
            END;
          Curr := Curr^.Next  
        END
    END;
  
  Curr := First;
  WHILE Curr <> NIL
  DO
    BEGIN
      WRITE(Curr^.Ch);
      Curr := Curr^.Next
    END       
END.
