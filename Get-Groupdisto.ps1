#gets all members of a group and lists their distributions lists

function Get-Distro ($Groupname)
{

    $users = Get-ADGroupMember -identity $groupname 

    $arr=@()
    ForEach ($user in $users) 

     {
        $out=New-Object psobject  
        $Aduser=Get-ADUser $user.SamAccountName -Properties MemberOf 
        Add-Member -InputObject $out -membertype Noteproperty -name Sam -value $user.samaccountname 
       $distro=""
        foreach($group in $ADuser.MemberOf){
            $Getgroup=Get-ADGroup $Group
            if ($getgroup.DistinguishedName -match ".*OU=DistributionLists,DC=Company,DC=com"){
                $distro+=  "$($Getgroup.Name); "
            }     
        }
        Add-Member -InputObject $out -membertype Noteproperty -name groups -value $distro
        $arr+=$out
    }


    return $arr




    
}
