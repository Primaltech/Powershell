# Quickly get IPs and Hostnames of Raspberry Pis on the local network segment
write-host "Scanning Network..."
$pingsweep = ( 1..254 | foreach  {
    (New-Object System.Net.NetworkInformation.Ping).SendPingAsync(("172.17.1.$_"))
})

# Wait for all tasks to finish
[System.Threading.Tasks.Task]::WaitAll($pingsweep)

# Filter ARP table results
write-host "Raspberry Pis on Network:"
(Get-NetNeighbor -AddressFamily IPv4 | Where-Object {($_.LinkLayerAddress -like "B8-27-EB-*") -and ($_.IPAddress -like "172.17.1.*") -and ($_.IPAddress -ne "172.17.1.255")}).IPAddress |  ForEach-Object {"$_,"+([system.net.dns]::GetHostByAddress($_)).hostname} | format-table -autosize