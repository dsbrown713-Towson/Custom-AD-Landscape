$basescriptPath = Split-Path -Parent $PSCommandPath
$grouplist = Get-Content ($basescriptPath + '\GroupList.txt')

ForEach ($group in $grouplist) {
	$name = $group.Split(',')[0]
	$samaccountname = $group.Split(',')[1]
	$category = $group.Split(',')[2]
	$path = "OU=Groups," + (Get-ADDomain).DistinguishedName
	New-ADGroup -Name $name `
	-DisplayName $name `
	-SamAccountName $samaccountname `
	-GroupCategory $category `
	-GroupScope Global `
	-Path $path
}