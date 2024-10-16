clear
#Challenge 1
function getIOC()
{
    # Website to search
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.6/IOC.html

    # Get all tr elements of the HTML document
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    # Create empty array to hold results
    $fullTable = @()

    # Iterate through every tr element
    for ($i = 1; $i -lt $trs.length; $i++)
    {
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        $fullTable += [pscustomobject] @{"Pattern" = $tds[0].innerText.Trim();`
                                         "Explaination" = $tds[1].innerText.Trim();}
    }

    $fullTable | Format-Table | Out-String
}

# Challenge 2
function getAccessLogs()
{
    # File path
    $path = "C:\Users\champuser\Desktop\Assignments\CSI-230\week8\access.log"
    
    # Array for results
    $table = @()

    # Read each line from the log file
    Get-Content $path | ForEach-Object{

        # Get IP 
        $ip = $_ -match '^(\S+)'
        $ip = $matches[1]

        # Get time
        $time = $_ -match '\[(.*?)\]'
        $time = $matches[1]

        # HTTP method and page which was visited  
        $method = $_ -match '"(\S+)\s+(\S+)'      
        $method = $matches[1]
        $page = $matches[2]

        # Extract protocol
        $protocol = $_ -match 'HTTP/([0-9.]+)'
        $protocol = "HTTP/$matches[1]"

        # Get the HTTP response code
        $response = $_ -match '\s(\d{3})\s' 
        $response = $matches[1]

        # Get browser info
        $referrer = $_ -match '"([^"]+)"\s+"[^"]+"'
        $referrer = $matches[1]

        # Store the parsed data in a custom object
        $table += [pscustomobject]@{"IP" = $ip
                                    "Time" = $time
                                    "Method" = $method
                                    "Page" = $page
                                    "Protocol" = $protocol
                                    "Response" = $response
                                    "Refferer" = $referrer}
    }

    # Return the logs
    return $table 
}

# Challenge 3
function Get-FilteredLogs {
    param (
        [string]$logFilePath,           
        [string[]]$indicators           # Array of indicators
    )

    # Get the access logs by calling the getAccessLogs function
    $accessLogs = getAccessLogs

    # Initialize an array to store the filtered results
    $filteredLogs = @()

    # Iterate over each log entry in accessLogs
    foreach ($entry in $accessLogs) {

        # Check if the Page property contains any of the indicators
        foreach ($indicator in $indicators) {
            if ($entry.Page -like "*$indicator*") {
                # If match is found, add the log entry to the filtered list
                $filteredLogs += [pscustomobject]@{
                    "IP" = $entry.IP
                    "Time" = $entry.Time
                    "Method" = $entry.Method
                    "Page" = $entry.Page
                    "Protocol" = $entry.Protocol
                    "Response" = $entry.Response
                    "Referrer" = $entry.Referrer
                }
                break  # No need to check further indicators for this log entry
            }
        }
    }

    # Return the filtered logs
    return $filteredLogs
}

# Function calls
getIOC
#clear

$table = getAccessLogs
$table | Format-Table | Out-String
#clear

# Get-FilteredLogs parameters and call
$logFilePath = "C:\Users\champuser\Desktop\Assignments\CSI-230\week8\access.log"
$indicators = @("/index.html", "w/1.1", "a=1&b=2", "/index.php?") # Change indicators for testing
$logTable = Get-FilteredLogs -logFilePath $logFilePath -indicators $indicators

# Output the filtered logs to the console
$logTable | Format-Table | Out-String
