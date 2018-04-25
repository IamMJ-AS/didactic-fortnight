# --------------------------------------------------- 
# Script: RenameFilesRemoveSpaces.ps1 
# Author: ed wilson, msft 
# Date: 01/07/2011 12:24:21 
# Keywords: Storage, Files 
# comments:  
# Modify the path to the appropriate location. When  
# you run the script it will 
# change file names from mixed case to all lower  
# case, and remplace spaces with 
# the underscore character.  
# --------------------------------------------------- 
$path = "C:\mytest" 
Get-ChildItem -Path $path -Recurse | 
Foreach-object { 
$name = $_.name -replace " ", "_" 
$name = $name.tolower() 
Rename-Item -Path $_.fullname -NewName $name 
}