$basescriptPath = Split-Path -Parent $PSCommandPath
$grouplist = Get-Content ($basescriptPath + '\GroupList.txt')

ForEach ($group in $grouplist) {
	$name = $group.Split('`t')[0]
	$samaccountname = $name -replace '\s',''
	$category = $group.Split('`t')[1]
	$path = $group.Split('`t')[2]
	$fullpath = $path + (Get-ADDomain).DistinguishedName
	New-ADGroup -Name $name `
	-DisplayName $name `
	-SamAccountName $samaccountname `
	-GroupCategory $category `
	-GroupScope Global `
	-Path $fullpath
}