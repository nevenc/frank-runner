:: This file is generated by build.xml
@echo off
setlocal enabledelayedexpansion
if not exist "%~dp0download\" (
	mkdir "%~dp0download"
)
if not exist "%~dp0build\tmp\build\" (
	mkdir "%~dp0build\tmp\build"
)
set DOWNLOAD_HELP=download https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u392-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip manually, move it to %~dp0download and restart this script
if not exist "%~dp0download\OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip" (
	echo "In case of errors %DOWNLOAD_HELP%"
	curl -f -o "%~dp0download\OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip.tmp" -L https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u392-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip
	if !errorlevel! neq 0 (
		echo "Please %DOWNLOAD_HELP%"
		goto error
	)
	move "%~dp0download\OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip.tmp" "%~dp0download\OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip"
)
if not exist "%~dp0build\jdk8u392-b08\" (
	tar --exclude=*/demo --exclude=*/sample --exclude=*/manual --exclude=*/src.zip -xvf "%~dp0download\OpenJDK8U-jdk_x64_windows_hotspot_8u392b08.zip" -C "%~dp0build\tmp\build"
	if !errorlevel! neq 0 (
		echo "Please %DOWNLOAD_HELP%"
		goto error
	)
	move "%~dp0build\tmp\build\jdk8u392-b08" "%~dp0build\jdk8u392-b08"
	RUN_INSTALL="true"
)
set DOWNLOAD_HELP=download https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.10-bin.zip manually, move it to %~dp0download and restart this script
if not exist "%~dp0download\apache-ant-1.10.10-bin.zip" (
	echo "In case of errors %DOWNLOAD_HELP%"
	curl -f -o "%~dp0download\apache-ant-1.10.10-bin.zip.tmp" -L https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.10-bin.zip
	if !errorlevel! neq 0 (
		echo "Please %DOWNLOAD_HELP%"
		goto error
	)
	move "%~dp0download\apache-ant-1.10.10-bin.zip.tmp" "%~dp0download\apache-ant-1.10.10-bin.zip"
)
if not exist "%~dp0build\apache-ant-1.10.10\" (
	tar --exclude=*/demo --exclude=*/sample --exclude=*/manual --exclude=*/src.zip -xvf "%~dp0download\apache-ant-1.10.10-bin.zip" -C "%~dp0build\tmp\build"
	if !errorlevel! neq 0 (
		echo "Please %DOWNLOAD_HELP%"
		goto error
	)
	move "%~dp0build\tmp\build\apache-ant-1.10.10" "%~dp0build\apache-ant-1.10.10"
)
set JDK_8_DIR=%~dp0%build\jdk8u392-b08
set JDK_11_DIR=%~dp0%build\jdk-11.0.21+9
set JDK_17_DIR=%~dp0%build\jdk-17.0.8+7
if not exist "%JDK_11_DIR%" (
	set RUN_INSTALL=true
)
if not exist "%JDK_17_DIR%" (
	set RUN_INSTALL=true
)
if not exist "%~dp0build\apache-maven-3.9.5" (
	set RUN_INSTALL=true
)
set JAVA_HOME=%JDK_8_DIR%
set ANT_HOME=%~dp0build\apache-ant-1.10.10
if "%RUN_INSTALL%" == "true" (
	call "%~dp0build\apache-ant-1.10.10\bin\ant" -emacs -buildfile "%~dp0build.xml" install
)
call "%~dp0build\apache-maven-3.9.5\bin\mvn.cmd" %*
if %errorlevel% equ 0 goto end
:error
rem https://superuser.com/questions/527898/how-to-pause-only-if-executing-in-a-new-window
set arg0=%0
if [%arg0:~2,1%]==[:] if not [%TERM_PROGRAM%] == [vscode] pause
exit /b %errorlevel%
:end
