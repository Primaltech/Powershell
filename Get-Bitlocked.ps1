#get a list of bitlocked computers on the domain with recovery password and creation time
#Run this script as a one-liner


Get-AdObject -Filter "objectclass -eq 'msFVE-RecoveryInformation'" -Properties DistinguishedName, msFVE-RecoveryPassword, WhenCreated | Select-Object -Property @{n="ComputerName";e={$_.DistinguishedName.Split(',',2)[1]}}, msFVE-RecoveryPassword , WhenCreated