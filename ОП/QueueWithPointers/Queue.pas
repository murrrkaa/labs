UNIT Queue;

INTERFACE
CONST
  Empty = '#';
TYPE
  EltType = CHAR;
           
  PROCEDURE EmptyQ;
  PROCEDURE AddQ(VAR NewQ: EltType);
  PROCEDURE HeadQ(VAR NewQ: EltType);
  PROCEDURE DelQ;

IMPLEMENTATION

TYPE
  Node = ^QueueP;
  QueueP = RECORD
             Ch: EltType;
             Next: Node
           END;
VAR
  First: Node;         
  
PROCEDURE EmptyQ;
VAR
  Curr, Delete: Node;
BEGIN
  Curr := First;
  WHILE Curr <> NIL
  DO
    BEGIN
      Delete := Curr;
      Curr := Curr^.Next;
      DISPOSE(Delete)
    END
END;

PROCEDURE AddQ(VAR NewQ: EltType);
VAR
  NewNode, Curr: Node;
BEGIN
  NEW(NewNode);
  NewNode^.Ch := NewQ;
  NewNode^.Next := NIL;
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

PROCEDURE DelQ;
VAR
  Delete: Node;
BEGIN
  IF First <> NIL
  THEN
    BEGIN
      Delete := First;
      First := First^.Next;
      DISPOSE(Delete)
    END
END;

PROCEDURE HeadQ(VAR NewQ: EltType);
BEGIN
  IF First <> NIL
  THEN
    NewQ := First^.Ch
  ELSE
    NewQ := Empty
END;
BEGIN
  First := NIL
END.
