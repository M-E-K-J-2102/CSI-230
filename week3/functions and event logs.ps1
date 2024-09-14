clear
# Get login and logout records from windows events
Get-EventLog System -source Microsoft-Windows-Winlogon

# Get login and logoff records from windows events and save to a variable
# Get the last 14 days 
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() # Empty array to fill custumly
for ($i = 0; $i -lt $loginouts.Count; $i++)
{
    # Creating an event property value
    $event = ""
    if ($loginouts[$i].InstanceId -eq "7001") {$event = "Logon"}
    if ($loginouts[$i].InstanceId -eq "7002") {$event  ="Logoff"}

    # Creating user property value
    $user =$loginouts[$i].ReplacementStrings[1]

    # Adding each new line (in form of a custom object) to our empty array
    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                         "ID" = $loginouts[$i].EventID;
                                         "Event" = $event;
                                         "User" = $user;}
}

$loginoutsTable
#clear
# Turning the SID into readable Usernames
$usernames = @()
foreach ($entry in $loginoutsTable)
{
    
    if ($loginoutsTable.$user)
    {
        try 
        {
            # Create a SecurityIdentifier object
            $sid = New-Object System.Security.Principal.SecurityIdentifier($entry.User)

            # Attempt to translate SID to NTAccount
            $entry.User = $sid.Translate([System.Security.Principal.NTAccount]).Value
        }
        catch 
        {
            # If translation fails, $user remains "Unknown User"
        }
    }

    # Create a new custom object with the translated username
    $usernames += [pscustomobject]@{
        "Time" = $entry.Time
        "ID" = $entry.ID
        "Event" = $entry.Event
        "User" = $entry.User
    }
}

# Output translated table
$usernames

# Call Get-Logs function to change amt of days the user goes back to 
$days = Read-Host -Prompt "How many days ago do you want to see the logs?"
Get-Logs -DaysAgo $days
#clear
# Call the Get-OnOffTimes function and output results
$startupShutdownTimes = Get-OnOffTimes -DaysAgo $days
$startupShutdownTimes