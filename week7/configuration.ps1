clear

function showConfig()
{
     # Show configuration (configuration should be displayed as pscustomobject)
        $config = @()
        $config += [pscustomobject]@{"Days" = Get-Content -Path C:\Users\champuser\Desktop\Assignments\CSI-230\week7/configuration.txt -TotalCount 1;
                                     "ExecutionTime" = (Get-Content -Path C:\Users\champuser\Desktop\Assignments\CSI-230\week7/configuration.txt -TotalCount 2)[-1]}
    return $config
}

function changeConfig()
{
    # This option will ask the user for a new configuration and
        # Replace the old configuration with new
        # Asks for day input
        Write-Host ("please enter the numbr of days for which the logs will be obtained: " | Out-String)
        $days = Read-Host
        if ($days -notmatch '^[1-9][0-9]*$') # Verifies user input
        {
            Write-Host ("Please enter a digit for days" | Out-String)
            continue
        }
        # Asks for time input
        Write-Host ("Please enter the daily execution time of the script: " | Out-String)
        $time = Read-Host
        if ($time -notmatch '^[0-1]?[0-9]{1}:[0-5]?[0-9]{1}\s[AP]M$') # Verifies user input
        {
            Write-Host ("please enter a correct time in the format hh:mm am/pm" | Out-String)
            continue
        }
        
        $days | Out-File -FilePath C:\Users\champuser\Desktop\Assignments\CSI-230\week7/configuration.txt
        $time | Out-File -FilePath C:\Users\champuser\Desktop\Assignments\CSI-230\week7/configuration.txt -append

        Write-Host ("Configuration Changed" | Out-String)
}

function menu()
{
    $menu = "`n"
    $menu += "Please choose an option below`n"
    $menu += "1 - Show config`n"
    $menu += "2 - Change config`n"
    $menu += "3 - Exit `n"

    $running = $true

    while ($running)
    {
        Write-Host ($menu | Out-String)
        $choice = Read-Host

        clear 

        if ($choice -eq 1)
        {
            $configure = showConfig
            $configure | Format-Table -AutoSize -Wrap
        }
        elseif ($choice -eq 2)
        {
            changeConfig
        }
        elseif ($choice -eq 3)
        {
            # Exits the program
            Write-Host ("Exiting Program..." | Out-String)
            $running = $false
        }
        else
        {
            Write-Host ("Please enter 1, 2, or 3" | Out-String)
        }
    }
}

