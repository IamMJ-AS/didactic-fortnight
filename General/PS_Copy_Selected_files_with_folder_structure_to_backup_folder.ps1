
$SourcePath = "D:\Airstrip"
$DestPath = "D:\AirStripInstallationFiles"
$ClientName = "HCA"
$SiteName = "Methodist"
$SiteType = "Prod"
$ServerRole = "Fed-Host_OB"
$ProdName = "AS1"
$ProdVer = "v1.3.X"
$BackupFolder = $ClientName+"_"+$SiteName+"_"+$SiteType+"_"+$ProdName+"_"+($env:computername)+"_"+$ServerRole+"_"+$ProdVer+"_Backup_"+$(get-date -f yyyy-MM-dd-HH-mm)

Copy-Item $SourcePath\ $DestPath\$BackupFolder\ -filter *.config -recurse