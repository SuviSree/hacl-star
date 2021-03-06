echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" -test
cd dist/msvc-compatible
cl *.c /I ../kremlin/include /I . /I ../kremlin/kremlib/dist/minimal /c || goto :error
for /F %%i in ('dir /b *-x86_64-msvc.asm') do (
  ml64 /c %%i || goto :error
)
lib *.obj || goto :error
echo "SUCCESS"
exit /b 0

:error
echo "Failed"
exit /b %errorlevel%
