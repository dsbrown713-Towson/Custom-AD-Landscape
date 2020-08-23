# Custom-AD-Landscape
A Powershell Script that fills Active Directory with whatever test data you choose.

It creates a layered OU structure complete with groups and users. 

Customizable through the various txt files. 


# !!!!WARNING!!!!

Do not use this script on a production environment as it can royally screw things up.

This script will randomize where the users are placed and which groups they are placed in. 

# Instructions
The AD_Landscape folder needs to be placed on the desktop of a user with admin privs. 

Edit the txt files as needed. 

Open a powershell terminal as admin then run invoke-ADLandscape.ps1 to create your AD environment.

# References
To generate a lot of fake names, use https://www.fakenamegenerator.com/order.php

For a more complicated and randomized version of this script check out https://github.com/davidprowe/BadBlood
