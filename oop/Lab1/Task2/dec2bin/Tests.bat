SET Program="%~1"

if %Program%=="" (
    echo Error: Please specify path to program.
    exit /B 1
)

%Program% 25 > "%TEMP%\Output.txt"
echo 11001 > "%TEMP%\ExpectedOutput.txt"
fc /W "%TEMP%\ExpectedOutput.txt" "%TEMP%\Output.txt" > nul || goto error
echo Test 1 passed

%Program% -1 > "%TEMP%\Output.txt"
fc ErrorMessage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 2 passed

%Program% 0 > "%TEMP%\Output.txt"
echo 0 > "%TEMP%\ExpectedOutput.txt"
fc /W "%TEMP%\ExpectedOutput.txt" "%TEMP%\Output.txt" > nul || goto error
echo Test 3 passed

%Program% 4294967294 > "%TEMP%\Output.txt"
echo 11111111111111111111111111111110 > "%TEMP%\ExpectedOutput.txt"
fc /W "%TEMP%\ExpectedOutput.txt" "%TEMP%\Output.txt" > nul || goto error
echo Test 4 passed

%Program% 4294967295 > "%TEMP%\Output.txt"
echo 11111111111111111111111111111111 > "%TEMP%\ExpectedOutput.txt"
fc /W "%TEMP%\ExpectedOutput.txt" "%TEMP%\Output.txt" > nul || goto error
echo Test 5 passed

%Program% 4294967296 > "%TEMP%\Output.txt"
fc ErrorMessage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 6 passed

%Program% -h > "%TEMP%\Output.txt"
fc Usage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 7 passed

%Program% 0xFF > "%TEMP%\Output.txt"
fc ErrorMessage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 8 passed

%Program% abc > "%TEMP%\Output.txt" 
fc ErrorMessage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 9 passed

%Program% 12abc > "%TEMP%\Output.txt"
fc ErrorMessage.txt "%TEMP%\Output.txt" > nul || goto error
echo Test 10 passed

echo All tests passed
exit /B 0

:error
echo Program testing failed
exit /B 1 


