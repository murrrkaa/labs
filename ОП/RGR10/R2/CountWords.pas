PROGRAM CountWordS(INPUT, OUTPUT);
USES ReadingWords, WordStorage;
VAR
  NewWord: STRING;
  InFile, OutFile: TEXT;
  I, Count: INTEGER;
  Root: Tree; 
BEGIN
  ASSIGN(InFile, 'InFile.txt');
  ASSIGN(OutFile, 'OutFile.txt');
  RESET(InFile);
  REWRITE(OutFile);
  Root := NIL;
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      WHILE NOT EOLN(InFile) 
      DO
        BEGIN
          CreateWord(InFile, NewWord);
          IF NewWord <> None
          THEN
            Insert(Root, NewWord)
        END;
      READLN(InFile)
    END;
  PrintTree(OutFile, Root);
  CLOSE(OutFile)
END.
