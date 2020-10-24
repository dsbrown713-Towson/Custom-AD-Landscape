param (
	[string]$civ = $( Read-Host "Enter civ name, ex. france" )
)

$basescriptPath = Split-Path -Parent $PSCommandPath
$userlist = Get-Content ($basescriptPath + '\UserPass.csv')
$salts = Get-Content ($basescriptPath + '\Salts.txt')
$numofusers = $userlist.count
$i = 0
$salt = "Error"

$offset = 0
Switch ($civ) {
	china {$offset = 2}
	england {$offset = 6}
	france {$offset = 10}
	germany {$offset = 14}
	japan {$offset = 18}
	rome {$offset = 22}
	russia {$offset = 26}
	spain {$offset = 30}
}

ForEach ($line in $salts) {
	if ($line.Split('`t')[0] -eq $civ) {
		$salt = $line.Split('`t')[1]
	}
}

ForEach ($user in $userlist) {
	$i++
	Write-Host Adding User $i/$numofusers
	$ou = $user.Split(',')[1]
	$first = $user.Split(',')[$offset]
	$last = $user.Split(',')[$offset+1]
	$name = $first + " " + $last
	$username = $user.Split(',')[$offset+2]
	$pass = $user.Split(',')[$offset+3]
	$path = $ou (Get-ADDomain).DistinguishedName
	$group = "CN=" + $user.Split(',')[0] + $path
	
	New-ADUser -Name $name `
	-AccountPassword (ConvertTo-Securestring $pass -AsPlainText -Force) `
	-ChangePasswordAtLogon $false `
	-DisplayName $name `
	-Enabled $true `
	-GivenName $first `
	-SamAccountName $username `
	-Surname $last `
	-UserPrincipalName ($username + "@" + $env:USERDNSDOMAIN.ToLower()) `
	-Path $path `
	
	Add-ADGroupMember -Identity $group -Members $username
}