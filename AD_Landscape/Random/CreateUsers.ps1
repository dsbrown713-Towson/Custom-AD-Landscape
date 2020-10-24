$basescriptPath = Split-Path -Parent $PSCommandPath
$userlist = Get-Content ($basescriptPath + '\US_Names.csv')
$passlist = Get-Content ($basescriptPath + '\PasswordList.txt')
$oulist = Get-Content ($basescriptPath + '\OUList.txt')
$numofusers = $userlist.count
$i = 0

ForEach ($user in $userlist) {
	$i++
	Write-Host Adding User $i/$numofusers
	$ou = Get-Random -InputObject $oulist
	$first = $user.Split(',')[0]
	$last = $user.Split(',')[1]
	$name = $first + " " + $last
	$pass = Get-Random -InputObject $passlist
	$username = $first.ToLower()[0] + $last.ToLower()
	$path1 = "OU=" + $ou.Split(' ')[0] + ","
	$path2 = $ou.Split(' ')[1]
	if($path2 -ne "null") {
		$path = $path1 + $path2 + (Get-ADDomain).DistinguishedName
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
	}
	if($path2 -eq "null") {
		$path = $path1 + (Get-ADDomain).DistinguishedName
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
	}
}