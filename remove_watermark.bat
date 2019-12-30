@ECHO OFF
setlocal enabledelayedexpansion
for %%f in (3rk*.swf) do (
  set /p val=<%%f
  echo "fullname: %%f"
  echo "name: %%~nf"
  java -jar jpex\ffdec.jar -removeCharacter %%f public_%%f 3553 3551
  echo "contents: !val!"
  del /f %%f
)