clear
#list all of the apache logs of xampp
Get-Content C:\xampp\apache\logs\access.log
clear
# List only last 5 apache logs
Get-Content C:\xampp\apache\logs\access.log -Tail 5
clear
# Display only logs thast contain 404 (not found) or 400 (bad request)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404',' 400 '
clear
# Display only logs that do not contain 200 (ok)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch
clear
# From every .log file in the directory, only get logs that contain the word 'error'
$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# Display last 5 elements of the result array
$A[-1..-5]
clear
# Get only logs that contain 404, save into $notFounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404'

# Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notFounds)

# Get ips as pscustomobject
$ips = @()
for ($i = 0; $i -lt $ipsUnorganized.Count; $i++)
{
    $ips += [pscustomobject]@{"IP" = $ipsUnorganized[$i].Value;}
}
$ips | Where-Object {$_.IP -like "10.*"}
clear
# Count ips from number 8
$ipsoftens = $ips | Where-object {$_.IP -like "10.*"}
$counts = $ipsoftens | Group ip
$counts | Select-Object Count, Name

