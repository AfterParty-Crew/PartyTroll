@echo off
color 0a
cd ..
echo Install Haxe libraries?
pause
cls
@echo on
haxelib install hmm
haxelib run hmm install
@echo off
echo ---------
echo Finished!
pause