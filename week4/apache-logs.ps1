# Create a function that will take 3 inputs:
# Input 1: Page visited or reffered from
# Input 2: HTTP code returned
# Input 3: Name of web browser
# Outputs the IP addresses that have visited the given page or referred from, with the given web browser and got the given http response.
# Must be called from main.ps1
function apacheLogs
{
    param
    (
        [string]$PageVisited,
        [int]$httpCode,
        [string]$browser
    )

    $ipAddresses = $filteredData | Select-Object -ExpandProperty IPAddress

    return $ipAddresses
}