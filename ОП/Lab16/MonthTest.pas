PROGRAM MonthTest(INPUT, OUTPUT);
USES
  MonthModule;
VAR
  M1, M2: Month;
BEGIN
  ReadMonth(INPUT, M1);
  WriteMonth(OUTPUT, M1)
END.
