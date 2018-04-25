$computer=”localhost“
$user=SupportAst
$password=A1rstr1p!16
$group="Administrators"

$objOu = [ADSI]”WinNT://$computer“

$objUser = $objOU.Create(“User“, $user)

$objUser.setpassword($password)

$objUser.SetInfo()

$objUser.description = “AirStrip Support User“

$objUser.SetInfo()

$objOU = [ADSI]”WinNT://$computer/$group,group”

$objOU.add(“WinNT://$computer/$user”)


$group = [ADSI]"WinNT://edlt/mygroup,group"

$group.Add("WinNT://edlt/mred,user")