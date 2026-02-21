PROGRAM TreeSort(INPUT, OUTPUT);
TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               Key: CHAR;
               LLink, RLink: Tree
             END;
VAR
  Root: Tree;
  Ch: CHAR;
PROCEDURE Insert(VAR Ptr: Tree; VAR Data: CHAR);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Key := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    IF Ptr^.Key > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      Insert(Ptr^.RLink, Data)
END; {Insert}
PROCEDURE PrintTree(Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITE(Ptr^.Key);
      PrintTree(Ptr^.RLink)
    END  
END; {PrintTree}
BEGIN {TreeSort}
  Root := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Insert(Root, Ch)
    END;
  PrintTree(Root);
  WRITELN
END.  {TreeSort}

