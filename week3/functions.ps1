function Get-Logs
{
    param 
    (
        [int]$DaysAgo  # Number of days to look back for event logs. default is 14
    )

    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$DaysAgo)
    $loginouts
}

function Get-OnOffTimes 
{
    param 
    (
        [int]$DaysAgo = 14  # Number of days to look back
    )

    # Initialize the array to store results
    $eventsTable = @()

    # Get the relevant event logs (startup and shutdown)
    $events = Get-EventLog System -After (Get-Date).AddDays(-$DaysAgo) |`
    Where-Object { $_.EventID -eq 6005 -or $_.EventID -eq 6006 }

    # Process each event
    foreach ($event in $events) {
        $eventType = ""

        # Determine event type based on EventID
        if ($event.EventID -eq "6005") {$eventType = "Startup"}
        if ($event.EventID -eq "6006") {$eventType = "Shutdown"}

        # Create a custom object for each event
        $eventsTable += [pscustomobject]@{
            Time  = $event.TimeGenerated
            ID    = $event.EventID
            Event = $eventType
            User  = "System"
        }
    }

    # Return the table of events
    return $eventsTable
}

