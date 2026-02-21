UNIT WordStorage;

INTERFACE

CONST
  None = '';
  

TYPE
  Tree = ^Node;
  Node = RECORD
           Word: STRING;
           LLink, RLink: Tree;
           Counter: INTEGER
         END;

PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
PROCEDURE PrintTree(VAR OutputFile: TEXT; Ptr: Tree);

IMPLEMENTATION
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
    IF Ptr^.Word > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      IF Ptr^.Word < Data
      THEN
        Insert(Ptr^.RLink, Data)
      ELSE
        Ptr^.Counter := Ptr^.Counter + 1; 
END;  {Insert}

PROCEDURE PrintTree(VAR OutputFile: TEXT; Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  
    BEGIN
      PrintTree(OutputFile, Ptr^.LLink);
      WRITELN(OutputFile, Ptr^.Word,' ', Ptr^.Counter);
      PrintTree(OutputFile, Ptr^.RLink);
    END;
END;  {PrintTree}
BEGIN
END.
