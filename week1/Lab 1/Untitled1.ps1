clear
# Get IPv4 address from Ethernet0 interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).IPAddress

# Get IPv4 PrefixLength from EthernetO Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "Ethernet0"}).PrefixLength
clear
# Show what classes there are from win32 library that starts with NET, sort alphabetically
Get-WmiObject -List | Where-Object {$_.__CLASS -like "win32_NET*"} | Sort-Object __Class
clear
# Get dhcp server ip and hide the table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled = true" | Select-Object`
-ExpandProperty DNSServerSearchOrder | Format-Table -HideTableHeaders
clear

# **Part 2:directory listings**
# Choose directory where i have .ps1 files
cd $PSScriptRoot

#List files based off file name
$files = (Get-ChildItem -Filter "*ps1")
for ($j = 0; $j -le $files.Count; $j++)
{
    if ($files[$j].Extension -like "*ps1")
    {
        Write-Host $files[$j].Name
    }
}
# I have multiple directories with very few ps1 files each
clear
#Create folder if it does not already exist
$folderPath = "$PSScriptRoot\outFolder"
if (Test-Path $folderPath)
{
    Write-Host "Folder already exists."
}
else
{
    New-Item -Path $folderPath -ItemType Directory
}
clear
# List all files in working directory (or any other dir that has .ps1 files
# Save results to outFolder as a .csv folder
cd $PSScriptRoot
$files = Get-ChildItem -Filter "*.ps1"
$folderPath = "$PSScriptRoot/outFolder/"
$filePath = Join-Path -Path $folderPath -ChildPath "out.csv"
$files | Where-Object { $_.Extension -eq ".ps1" } | Select-Object Name | `
Export-Csv -Path $filePath -NoTypeInformation
clear
# Without changing directory (don't go into outfolder), find every .csv file
# Recursively and change their extensions to .log 
# Recursively display all the files (not directories)
$files = Get-ChildItem -Recurse -Filter "*.csv"
$files | ForEach-Object {$newName = $_.FullName -replace '.csv', '.log'}
Get-ChildItem -Recurse -File
