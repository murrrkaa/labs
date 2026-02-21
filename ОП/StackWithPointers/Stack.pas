UNIT Stack;

INTERFACE
TYPE
  EltType = CHAR;

PROCEDURE Push(NewS: EltType);
PROCEDURE Pop(VAR NewS: EltType);
FUNCTION Empty: BOOLEAN;
FUNCTION Top: EltType;


IMPLEMENTATION

TYPE
  S = ^StackType;
  StackType = RECORD
                Ch: EltType;
                Next: S
              END;
VAR
  NewStack: EltType;
  First: S;
  
PROCEDURE Push(NewS: EltType);
VAR
  NewStack: S;
BEGIN
  NEW(NewStack);
  NewStack^.Ch := NewS;
  NewStack^.Next := NIL;
  IF First = NIL
  THEN
    First := NewStack
  ELSE
    BEGIN
      NewStack^.Next := First;
      First := NewStack
    END
END;

PROCEDURE Pop(VAR NewS: EltType);
VAR
  Del: S;
BEGIN
  IF First <> NIL
  THEN
    BEGIN
      Del := First;
      NewS := First^.Ch;
      First := First^.Next;
      DISPOSE(Del)
    END;
END;

FUNCTION Empty: BOOLEAN;
BEGIN
  IF First = NIL
  THEN
    Empty := TRUE
  ELSE
    Empty := FALSE
END;

FUNCTION Top: CHAR;
BEGIN
  IF First <> NIL
  THEN
    Top := First^.Ch
END;

BEGIN
  First := NIL
END.
