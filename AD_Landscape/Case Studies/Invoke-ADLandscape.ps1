param (
	[string]$civ = $( Read-Host "Enter civ name, ex. france" )
)
$civ = $civ.ToLower()

$basescriptPath = Split-Path -Parent $PSCommandPath

Write-Host Creating OU Structure
.($basescriptPath + '\CreateOUS.ps1')

Write-Host Creating Groups
.($basescriptPath + '\CreateGroups.ps1')

Write-Host Creating Users
.($basescriptPath + '\CreateUsers.ps1') -civ $civ

Write-Host Adding Users to Groups
.($basescriptPath + '\AddUsersToGroup') -civ $civ