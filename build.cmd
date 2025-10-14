REM Pascal
mp.exe src\main.pas -code:2000 -ipath:madpascal\lib -o:bin\main.a65

REM Assemble
mads.exe bin\main.a65 -x -i:madpascal\base -o:bin\main.xex -l:bin\main.lst -t:bin\main.lab 