PROGRAM CountWordS(INPUT, OUTPUT);
USES ReadingWords, WordStorage;
VAR
  NewWord: STRING;
  InFile, OutFile: TEXT;
  I, Count: INTEGER; 
BEGIN
  ASSIGN(InFile, 'InFile.txt');
  ASSIGN(OutFile, 'OutFile.txt');
  RESET(InFile);
  REWRITE(OutFile);
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      WHILE NOT EOLN(InFile) 
      DO
        BEGIN
          CreateWord(InFile,NewWord);
          IF NewWord <> None
          THEN
            PutWord(NewWord)
        END;
      READLN(InFile)
    END;
  FOR I := First TO GetWordsCount()
  DO
    BEGIN
      GetWord(I, Count, NewWord);
      WRITELN(OutFile, NewWord, ' ', Count)
    END;
  CLOSE(OutFile)
END.
