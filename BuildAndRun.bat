echo off
del *.o
del *.hi
del *.exe
ghc Grue
del *.o
del *.hi
echo Running Flathead...
Grue.exe
echo Run finished.
pause