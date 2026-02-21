SET Program="%~1"
SET SearchedText="World"
SET SearchedTextLowerCase="world"

if %Program%=="" (
    echo Error: Please specify path to program.
    exit /B 1
)

REM Find text in input file
%Program% input.txt %SearchedText% > "%TEMP%\output.txt"
fc Expected_Output.txt "%TEMP%\output.txt" > nul || goto error
echo Test 1 passed

REM Find text with different register
%Program% input.txt %SearchedTextLowerCase% > nul
if %ERRORLEVEL% NEQ 1 goto error
echo Test 2 passed

REM Find text in empty file
%Program% Empty.txt %SearchedText% > nul
if %ERRORLEVEL% NEQ 1 goto error
echo Test 3 passed

REM Find text in missing file 
%Program% Missing.txt %SearchedText% > nul
if %ERRORLEVEL% NEQ 3 goto error
echo Test 4 passed

REM If searched text is not specified, program must fail
%Program% input.txt > nul
if %ERRORLEVEL% NEQ 2 goto error
echo Test 5 passed

REM If input file is not specified, program must fail
%Program% %SearchedText% > nul
if %ERRORLEVEL% NEQ 2 goto error
echo Test 6 passed

REM If input file and text is not specified, program must fail
%Program% > nul
if %ERRORLEVEL% NEQ 2 goto error
echo Test 7 passed

echo Program tests passed
exit /B 0

:error
echo Program testing failed
exit /B 1