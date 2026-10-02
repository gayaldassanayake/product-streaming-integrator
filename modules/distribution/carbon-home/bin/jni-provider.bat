@echo off
rem Copyright (c) 2026, WSO2 LLC. (http://www.wso2.org).
rem
rem WSO2 LLC. licenses this file to you under the Apache License,
rem Version 2.0 (the "License"); you may not use this file except
rem in compliance with the License.
rem You may obtain a copy of the License at
rem
rem http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing,
rem software distributed under the License is distributed on an
rem "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
rem KIND, either express or implied.  See the License for the
rem specific language governing permissions and limitations
rem under the License.

setlocal

if "%JAVA_HOME%" == "" goto noJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto noJavaHome
goto checkServer

:noJavaHome
echo "You must set the JAVA_HOME variable before running CARBON."
goto end

:checkServer
if "%CARBON_HOME%"=="" set CARBON_HOME=%~sdp0..
SET curDrive=%cd:~0,1%
SET wsasDrive=%CARBON_HOME:~0,1%
if not "%curDrive%" == "%wsasDrive%" %wsasDrive%:
if not exist "%CARBON_HOME%\bin\kernel-version.txt" goto noServerHome
goto commandLifecycle

:noServerHome
echo CARBON_HOME is set incorrectly or CARBON could not be located. Please set CARBON_HOME.
goto end

:commandLifecycle
set CMD=RUN %*
goto runTool

:runTool
set CURRENT_DIR=%cd%

cd %CARBON_HOME%\bin
echo JAVA_HOME environment variable is set to %JAVA_HOME%
echo CARBON_HOME environment variable is set to %CARBON_HOME%
"%JAVA_HOME%\bin\java" -cp ".\*;..\bin\tools\*" -Dcarbon.home="%CARBON_HOME%" -Dwso2.carbon.tool="jni-provider" org.wso2.carbon.tools.CarbonToolExecutor %1 %2 %3 %4

:end
goto endlocal

:endlocal
endlocal
