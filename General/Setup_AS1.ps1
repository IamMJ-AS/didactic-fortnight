New-Item -ItemType directory -Path C:\AirStrip
New-Item -ItemType directory -Path C:\AirStrip\AMP
New-Item -ItemType directory -Path C:\AirStrip\ASMPI
New-Item -ItemType directory -Path C:\AirStrip\AOB
New-Item -ItemType directory -Path C:\AirStrip\Fed-Host
New-Item -ItemType directory -Path C:\AirStrip\Service
New-Item -ItemType directory -Path C:\AirStrip\Service\AirStripObSyncService
#Set Password Not To Expire
net user ampuser A1rstr1p! /add
Rename-Item 'IIS:\Sites\Default Web Site' 'AirStrip'
New-WebAppPool -Name AMP
Set-ItemProperty IIS:\AppPools\AMP -name processModel -value @{idletimeout="0"}
New-WebAppPool -Name ASMPI
Set-ItemProperty IIS:\AppPools\ASMPI -name processModel -value @{idletimeout="0"}
New-WebAppPool -Name AOB
Set-ItemProperty IIS:\AppPools\AOB -name processModel -value @{idletimeout="0"}
New-WebAppPool -Name Fed-Host
Set-ItemProperty IIS:\AppPools\Fed-Host -name processModel -value @{idletimeout="0"}
New-WebApplication -Name AMP -Site 'AirStrip' -PhysicalPath E:\AirStrip\AMP -ApplicationPool AMP
New-WebApplication -Name ASMPI -Site 'AirStrip' -PhysicalPath E:\AirStrip\ASMPI -ApplicationPool ASMPI
New-WebApplication -Name AOB -Site 'AirStrip' -PhysicalPath E:\AirStrip\AOB -ApplicationPool AOB
New-WebApplication -Name Fed-Host -Site 'AirStrip' -PhysicalPath E:\AirStrip\Fed-Host -ApplicationPool Fed-Host
Set-WebConfigurationProperty -filter "/system.webServer/security/authentication/windowsAuthentication" -name enabled -value true -PSPath "IIS:\" -location 'AirStrip'