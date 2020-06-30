$userlist = Get-Content C:\Users\$env:USERNAME\Desktop\GoodBlood\US_Names.csv
$grouplist = Get-Content C:\Users\$env:USERNAME\Desktop\GoodBlood\GroupList.txt
$groups = ""

ForEach ($group in $grouplist) {
	if($groups -ne "") {
		$groups = $groups + "," + $group.Split(',')[0]
	}
	if($groups -eq "") {
		$groups = $groups + $group.Split(',')[0]
	}
}

$numofusers = $userlist.count
$i = 0

ForEach ($name in $userlist) {
	$i++
	Write-Host Adding Users to random groups: $i/$numofusers
	$first = $name.Split(',')[0]
	$last = $name.Split(',')[1]
	$username = $first.ToLower()[0] + $last.ToLower()
	$path = "OU=Groups," + (Get-ADDomain).DistinguishedName
	$g = Get-Random -InputObject $groups.Split(',')
	$gname = "CN=$g," + $path
	Add-ADGroupMember -Identity $gname -Members $username
}