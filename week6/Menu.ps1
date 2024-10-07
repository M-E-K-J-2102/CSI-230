# Use dot notation to acces the functions
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot C:\Users\champuser\Desktop\Assignments\CSI-230\week4\parsing.ps1)
Clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display apache logs`n"
$Prompt += "2 - Display failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start / Stop Chrome`n"
$Prompt += "5 - Exit`n"

$operation = $true

while ($operation)
{
    Write-Host $Prompt | Out-String
    $choice = Read-Host 
     
    clear
   
    if ($choice -eq 1)
    {
           # Display last 10 apache logs 
           # (Utilize function ApacheLogs1 from assignment Parsing Apache Logs)
          $logs = ApacheLogs1
          $logs | Format-Table -Autosize -Wrap
    }
    elseif($choice -eq 2)
    {
        # Display last 10 failed logins for all users (Utilize 
        # function getFailedLogins from lab Local User Management Menu) 
        $days = 10
        $failedLogins = getFailedLogins -timeBack $days
        $failedLogins | Format-Table -Autosize -Wrap

    }
    elseif($choice -eq 3)
    {
        # Display at risk users 
        # (Utilize your function from lab Local User Management Menu)
        Write-Host ("How many days?" | Out-String)
        $days = Read-Host
        if (-not $days -match '^[1-9][0-9]*$')
            {
                Write-Host ("Enter an integer greater than 0" | Out-String)
                continue
            }
        endangeredUsers -timeBack $days
    }
    elseif($choice -eq 4)
    {
        # Start Chrome web browser and navigate it to champlain.edu - if no 
        # instances of Chrome is running (from lab Process Management - 1)
        webProcess
    }
    elseif($choice -eq 5)
    {
        # Exit program
        Write-Host("Exiting program..." | Out-String)
        $operation = $false
    }
    else
    {
        Write-Host ("Please enter a number 1-5" | Out-String)
    }   
}