echo off
del *.o
del *.hi
del *.exe
ghc flathead
del *.o
del *.hi
echo Running Flathead...
flathead.exe
echo Run finished.
pause