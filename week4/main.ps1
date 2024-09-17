# Calls apache-logs function
. (Join-Path $PSScriptRoot "apache-logs.ps1")
. (Join-Path $PSScriptRoot "s.ps1")

$pageVisited = Get-Content C:\xampp\apache\logs\access.log | `
Select-String -Pattern '"GET\s+([^ ]+)' | ForEach-Object {$_.Matches.Groups[1].Value}

$httpCode = Get-Content C:\xampp\apache\logs\access.log | `
Select-String -Pattern '\b[0-9]{3}\b'

$browser = Get-Content C:\xampp\apache\logs\access.log | `
Select-String '\"[^\"]+\"\s+\"([^\"]+)$'

$Address = apacheLogs -pageVisited $pageVisited -httpCode $httpsCode -browser $browser
$Address