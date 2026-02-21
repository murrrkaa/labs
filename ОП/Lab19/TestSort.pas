PROGRAM Test(INPUT, OUTPUT);
USES Sort;
VAR
  M1: Month;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FIn, FOut: TEXT;
BEGIN
  ASSIGN(DateFile, 'DFTest.DAT');
  ASSIGN(TFile, 'TFTest.DAT');
  ASSIGN(FIn, 'FITest.TXT');
  ReadDate(FIn, D);
  ReadDate(FIn, VarDate);
  IF Less(VarDate, D)
  THEN
    BEGIN
      WriteDate(FOut, VarDate);
      WriteDate(FOut, D);  
    END
  ELSE
    BEGIN
      WriteDate(FOut, D);
      WriteDate(FOut, VarDate);  
    END;
  REWRITE(DateFile);
  RESET(FOut);
  WHILE NOT EOF(FOut)
  DO
    BEGIN
      ReadDate(FOut, VarDate);
      WRITE(DateFile, VarDate)
    END;
  RESET(DateFile);
  CopyOut(DateFile)
END.
