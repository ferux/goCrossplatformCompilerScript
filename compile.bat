@ECHO OFF
REM Check if application name is specified. Otherwise take folder's name.
IF [%1] == [] (for %%* in (.) do SET app=%%~nx*) ELSE (SET app=%1)

WHERE 7z >nul 2>&1 && GOTO :ArchTrue || GOTO :ArchFalse
:ArchFalse
    SET arch=false
    GOTO :MAIN
:ArchTrue
    SET arch=true
    GOTO :MAIN
:MAIN
IF EXIST ./bin GOTO COMPILE
MKDIR bin
echo [%DATE% %TIME%] Directory for binaries 'bin' has been created.

:COMPILE
    ECHO [%DATE% %TIME%] Starting compilation. Output name: %app%
    SET GOARCH=amd64
    SET GOOS=linux
    SET name=%GOOS%_%app%_%GOARCH%
    ECHO [%DATE% %TIME%] Compile for %GOOS%_%GOARCH%
    go build -o ./bin/%name%
    IF %arch%==true CALL :ARCH_ME %name% %GOOS% 9
    
    SET GOOS=windows
    ECHO [%DATE% %TIME%] Compile for %GOOS%_%GOARCH%
    SET name=%GOOS%_%app%_%GOARCH%
    go build -o ./bin/%name%
    IF %arch%==true CALL :ARCH_ME %name% %GOOS% 9

    SET GOARCH=386
    SET GOOS=linux
    ECHO [%DATE% %TIME%] Compile for %GOOS%_%GOARCH%
    SET name=%GOOS%_%app%_%GOARCH%
    go build -o ./bin/%name%
    IF %arch%==true CALL :ARCH_ME %name% %GOOS% 9

    SET GOOS=windows
    ECHO [%DATE% %TIME%] Compile for %GOOS%_%GOARCH%
    SET name=%GOOS%_%app%_%GOARCH%
    go build -o ./bin/%name%
    IF %arch%==true CALL :ARCH_ME %name% %GOOS% 9

    ECHO [%DATE% %TIME%] Compilation completed.
    GOTO EOF

REM Function which accepts the following arguments:
REM %1 = Source File
REM %2 = OS
REM %3 = Compression Ratio
:ARCH_ME
    IF %2==linux (
        SET ext=gz
        SET method=gzip
        )
    IF %2==windows (
        SET ext=zip
        SET method=zip
        )
    ECHO [%DATE% %TIME%] Compressing file %1 using method %method% [cr:%3]. Output: %1.%ext%
    7z a -t%method% ./bin/%1.%ext% ./bin/%1 -mx=%3
    DEL .\bin\%1
EXIT /B 0
:EOF
ECHO Bye-bye
