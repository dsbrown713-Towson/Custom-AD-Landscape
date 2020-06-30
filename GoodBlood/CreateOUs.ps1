$oulist = Get-Content C:\Users\$env:USERNAME\Desktop\GoodBlood\OUList.txt

ForEach($ou in $oulist) {
	$name = $ou.Split(' ')[0]
	$path = $ou.Split(' ')[1]
	if($path -ne "null") {
        $path = $path + (Get-ADDomain).DistinguishedName
		New-ADOrganizationalUnit -Name $name `
		-ProtectedFromAccidentalDeletion $True `
		-Path $path
	}
    if($path -eq "null") {
        $path = (Get-ADDomain).DistinguishedName
        New-ADOrganizationalUnit -Name $name `
		-ProtectedFromAccidentalDeletion $True `
		-Path $path
    } 
}

New-ADOrganizationalUnit -Name Groups `
-ProtectedFromAccidentalDeletion $True `