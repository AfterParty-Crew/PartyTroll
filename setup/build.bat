@echo off
color 0a
cd ..
echo BUILDING GAME
haxelib run lime build windows
echo.
echo done.
pause