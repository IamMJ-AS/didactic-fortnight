#region ****************************** Execution started - TreeNode: Users ******************************
function func_Users()
{
Get-LocalUser
}


 func_Users | Select-Object -Property 'Name','FullName','Description','Disabled','LockedOut' 
#endregion ****************************** Execution completed - TreeNode: Users ******************************
#region ****************************** Execution started - TreeNode: Users ******************************
function func_Users()
{
Get-LocalUser
}

function action()
{
$fieldDescriptions = @(
	(New-FieldDescription -Name 'Name' -HelpMessage 'The name(s) of the local user(s) you want to create' -Type 'System.String[]' -DefaultValue $null -IsMandatory $true),
	(New-FieldDescription -Name 'Password' -HelpMessage 'The password to apply to the new local user(s)' -Type 'System.Security.SecureString' -DefaultValue $null -IsMandatory $true),
	(New-FieldDescription -Name 'Full Name' -HelpMessage 'The full name to apply to the new local user(s)' -Type 'System.String' -DefaultValue $null -IsMandatory $false),
	(New-FieldDescription -Name 'Description' -HelpMessage 'The description to apply to the new local user(s)' -Type 'System.String' -DefaultValue $null -IsMandatory $false),
	(New-FieldDescription -Name 'User Must Change Password At Next Logon' -HelpMessage 'A flag indicating that the new user(s) must change their password the next time they log on' -Type 'System.Management.Automation.SwitchParameter' -DefaultValue $false -IsMandatory $false),
	(New-FieldDescription -Name 'User Cannot Change Password' -HelpMessage 'A flag indicating that the new user(s) cannot change their password' -Type 'System.Management.Automation.SwitchParameter' -DefaultValue $false -IsMandatory $false),
	(New-FieldDescription -Name 'Password Never Expires' -HelpMessage 'A flag indicating that the password never expires for the new user(s)' -Type 'System.Management.Automation.SwitchParameter' -DefaultValue $false -IsMandatory $false),
	(New-FieldDescription -Name 'Account Is Disabled' -HelpMessage 'A flag indicating that the new user(s) are disabled' -Type 'System.Management.Automation.SwitchParameter' -DefaultValue $false -IsMandatory $true),
	(New-FieldDescription -Name 'Computer Name' -HelpMessage 'The name(s) of the computer(s) where you want to create the new local user(s)' -Type 'System.String[]' -DefaultValue @() -IsMandatory $true),
	(New-FieldDescription -Name 'Credential' -HelpMessage 'The name of the user account you want to use to create the new local user(s)' -Type 'System.String' -DefaultValue $null -IsMandatory $false)
)
$result = Read-Input -Caption 'New Local User' -Message 'Please configure your new local user(s) using the fields provided below.' -FieldDescription $fieldDescriptions
if ($result.Keys.Count) {
	if ((-not $result['Name']) -or (-not $result['Password'])) {
		Show-MessageBox -Text 'Name and password are required parameters.' | Out-Null
	} else {
		New-LocalUser -Name $result['Name'] -Password $result['Password'] -FullName $result['Full Name'] -Description $result['Description'] -UserMustChangePasswordAtNextLogon:$result['User Must Change Password At Next Logon'] -UserCannotChangePassword:$result['User Cannot Change Password'] -PasswordNeverExpires:$result['Password Never Expires'] -AccountIsDisabled:$result['Account Is Disabled'] -ComputerName $result['Computer Name'] -Credential $result['Credential']
	}
}
}


 func_Users | where { $_.Name -eq 'Administrator'} | action 
#endregion ****************************** Execution completed - TreeNode: Users ******************************
#region ****************************** Execution started - TreeNode: Users ******************************
function func_Users()
{
Get-LocalUser
}

function action()
{
param(
	[string]$GroupName
)

$input | ForEach-Object {
	Get-LocalGroup -Name $GroupName -ComputerName $_.ComputerName -Credential $_.Credential | Add-LocalGroupMember -Member $_.Name
}
}


 func_Users | where { $_.Name -eq 'ampuser'} | action -GroupName 'Administrators' 
#endregion ****************************** Execution completed - TreeNode: Users ******************************
#region ****************************** Execution started - TreeNode: Users ******************************
function func_Users()
{
Get-LocalUser
}


 func_Users | Sort-Object -property 'Name' 
#endregion ****************************** Execution completed - TreeNode: Users ******************************
