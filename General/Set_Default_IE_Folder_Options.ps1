#  Declare Registry Path 
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' #  Declare Registry Path 
Set-ItemProperty $key AlwaysShowMenus 1  # always show menus
#Set-ItemProperty $key AutoCheckSelect 0
#Set-ItemProperty $key DontPrettyPath 1 # Disable PrettyPath
#Set-ItemProperty $key Filter 0
Set-ItemProperty $key Hidden 1 #  Show Show hidden files, folders and drives
Set-ItemProperty $key HideDrivesWithNoMedia 0 # Show empty drives in the computer folder
Set-ItemProperty $key HideFileExt 0 # Show file Extensions for known file types
Set-ItemProperty $key HideIcons 0 #Show generic icons
Set-ItemProperty $key HideMergeConflicts 0 # show merge conflicts
Set-ItemProperty $key IconsOnly 1 # display file icon on thumbnails
Set-ItemProperty $key ListviewAlphaSelect 0
Set-ItemProperty $key ListviewShadow 0
Set-ItemProperty $key MapNetDrvBtn 0 # don't show Map Network Drive Button
Set-ItemProperty $key SeparateProcess 0 # don't launch windows in a seperate process
Set-ItemProperty $key ServerAdminUI 1
Set-ItemProperty $key ShowCompColor 1
Set-ItemProperty $key ShowInfoTip 1
Set-ItemProperty $key ShowPreviewHandlers 0
Set-ItemProperty $key ShowStatusBar 1
Set-ItemProperty $key ShowSuperHidden 1
Set-ItemProperty $key ShowTypeOverlay 1
Set-ItemProperty $key StartMenuAdminTools 1
Set-ItemProperty $key StartMenuInit 6
Set-ItemProperty $key Start_SearchFiles 1
Set-ItemProperty $key StoreAppsOnTaskbar 1
Set-ItemProperty $key TaskbarAnimations 0
Set-ItemProperty $key WebView 1
Stop-Process -processname explorer # kill windows explorer so that it will restart