UNIT FileProcessing;

INTERFACE

USES ReadingWords, WordStorage;
PROCEDURE ProcessingInputFile;

IMPLEMENTATION
CONST
  LimitWords = 30000;

TYPE
  FileOfNode = FILE OF Node;

VAR
  TempOne, TempTwo: FileOfNode;
  FirstTree: BOOLEAN;
  OutFile, InFile: TEXT;

PROCEDURE Merge(VAR Root: Tree; VAR FileNode: Node; VAR NodeReaded: BOOLEAN);
VAR
  Found, FoundEqual: BOOLEAN;
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      Merge(Root^.LLink, FileNode, NodeReaded);
      Found := FALSE;
      FoundEqual := FALSE;
      WHILE (NOT EOF(TempOne)) AND (NOT Found) AND (NOT FoundEqual)
      DO
        BEGIN
          IF NOT NodeReaded 
          THEN
            READ(TempOne, FileNode);
            
          IF CompareString(FileNode.Word, Root^.Word) = 1
          THEN
            BEGIN
              Found := TRUE;
              NodeReaded := TRUE
            END;
            
          IF CompareString(FileNode.Word, Root^.Word) = 2
          THEN
            BEGIN
              WRITE(TempTwo, FileNode);
              NodeReaded := FALSE
            END;
            
          IF CompareString(FileNode.Word, Root^.Word) = 0
          THEN
            BEGIN
              FoundEqual := TRUE;
              FileNode.Counter := FileNode.Counter + Root^.Counter;
              NodeReaded := FALSE;
              WRITE(TempTwo, FileNode)
            END 
        END;
      IF NOT FoundEqual
      THEN
        WRITE(TempTwo, Root^); 
      Merge(Root^.RLink, FileNode, NodeReaded)
    END
END;

PROCEDURE CopyWords(VAR F1, F2: FileOfNode);
VAR
  FileNode: Node;
BEGIN
  WHILE (NOT EOF(F1))
  DO
    BEGIN
      READ(F1, FileNode);
      WRITE(F2, FileNode)
    END
END;

PROCEDURE MergeTreeToFile(VAR Root: Tree);
VAR
  NodeReaded: BOOLEAN;
  FileNode: Node;
BEGIN
  {Слияние дерева и временного файла}
  RESET(TempOne);
  REWRITE(TempTwo);
  NodeReaded := FALSE;
  Merge(Root, FileNode, NodeReaded);
  {Перенос данных во временный файл}
  IF NodeReaded
  THEN
    WRITE(TempTwo, FileNode);
  {Копирование остатка из первого файла}
  CopyWords(TempOne, TempTwo);  
  REWRITE(TempOne);
  RESET(TempTwo);
  CopyWords(TempTwo, TempOne)
END;

PROCEDURE CopyFirstTree(VAR TempOne: FileOfNode; VAR Root: Tree);
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      CopyFirstTree(TempOne, Root^.LLink);
      WRITE(TempOne, Root^);
      CopyFirstTree(TempOne, Root^.RLink)
    END
END;

PROCEDURE TransferTree(VAR Root: Tree);
BEGIN
  IF FirstTree
  THEN 
    BEGIN
      FirstTree := FALSE;
      REWRITE(TempOne);
      CopyFirstTree(TempOne, Root)
    END
  ELSE
    MergeTreeToFile(Root);
  DestroyTree(Root)
END;

PROCEDURE WriteStatistic(VAR OutFile: TEXT);
VAR
  FileNode: Node;
BEGIN
  ASSIGN(OutFile, 'OutFile.txt');
  REWRITE(OutFile);
  RESET(TempOne);
  WHILE (NOT EOF(TempOne))
  DO
    BEGIN
      READ(TempOne, FileNode);
      WRITELN(OutFile, FileNode.Word, ' ', FileNode.Counter)
    END
END;

PROCEDURE ProcessingInputFile;
VAR
  NewWord: STRING;
  Root: Tree;
  MaxWords: INTEGER; 
BEGIN
  ASSIGN(InFile, 'InFile.txt');
  RESET(InFile);
  Root := NIL;
  MaxWords := 0;
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      WHILE NOT EOLN(InFile) 
      DO
        BEGIN
          CreateWord(InFile,NewWord);
          IF NewWord <> None
          THEN
            BEGIN
              Insert(Root, NewWord);
              MaxWords := MaxWords + 1
            END;
          IF MaxWords = LimitWords
          THEN
            BEGIN
              TransferTree(Root)
            END
        END;
      READLN(InFile)
    END;
  TransferTree(Root);
  WriteStatistic(OutFile)
END;   

BEGIN
  FirstTree := TRUE
END.
