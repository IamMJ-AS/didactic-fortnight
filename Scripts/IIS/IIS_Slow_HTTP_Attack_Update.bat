@ECHO off
:: ###########################
:: IIS_Slow_HTTP_Attack_Update
:: Version: 2.0
:: Updated: 2016.05.27
:: Author: M Johnson
:: ###########################
:: If running 64-bit Windows, use Appcmd.exe in %windir%\system32\inetsrv , not %windir%\syswow64\inetsrv directory
cd %windir%\system32\inetsrv
c:
ECHO %CD%
::pause

::Request Fiiltering: Enable "Allow unlisted File name extensions"
appcmd.exe set config  -section:system.webServer/security/requestFiltering /fileExtensions.allowUnlisted:"True"  /commit:apphost

::Request Fiiltering: Enable " Allow unlisted verbs"
appcmd.exe set config  -section:system.webServer/security/requestFiltering /verbs.allowUnlisted:"True"  /commit:apphost

::Request Fiiltering: Enable "Allow high-bit characters"
appcmd.exe set config  -section:system.webServer/security/requestFiltering /allowHighBitCharacters:"True"  /commit:apphost

:: Request Limits: Set "Maximum allowed content length (bytes)" field to 10000000
appcmd.exe set config  -section:system.webServer/security/requestFiltering /requestLimits.maxAllowedContentLength:"10000000" /commit:apphost

:: Request Limits: Set "Maximum URL Length (bytes)" field to 1024
appcmd.exe set config  -section:system.webServer/security/requestFiltering /requestLimits.maxUrl:"1024" /commit:apphost

:: Request Limits: Set "Maximum query string (bytes)" field to 512
appcmd.exe set config  -section:system.webServer/security/requestFiltering /requestLimits.maxQueryString:"512" /commit:apphost

:: Add Size limit for HTTP Headers to 100
appcmd.exe set config  -section:system.webServer/security/requestFiltering /+"requestLimits.headerLimits.[header='Content-type',sizeLimit='100']" /commit:apphost

::pause

