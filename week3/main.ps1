. (Join-Path $PSScriptRoot "functions and event logs.ps1")
#clear

# Get login and logoffs from the last 15 days
$loginoutsTable = Get-Logs -DaysAgo -15
$loginoutsTable

# Get shutdowns from the last 25 days
$startups = Get-OnOffTimes -DaysAgo 25 | Where-Object {$_.Event -eq "Shutdown"}
$startups

# Get startups from the last 25 days
$shutdowns = Get-OnOffTimes -DaysAgo 25 | Where-Object {$_.Event -eq "Startup"}
$shutdowns