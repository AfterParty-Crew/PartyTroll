@echo off
color 0a
cd ..
@echo on
echo Install Haxe libraries?
pause
cls
haxelib install hmm
haxelib run hmm install
@echo off
echo ---------
echo Finished!
pause