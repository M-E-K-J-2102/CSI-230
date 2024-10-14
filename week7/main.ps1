. (Join-path $PSScriptRoot configuration.ps1)
. (Join-path $PSScriptRoot Email.ps1)
. (Join-path $PSScriptRoot scheduler.ps1)
. "C:\Users\champuser\Desktop\Assignments\CSI-230\week6\Event-Logs.ps1" 

# User menu 
# menu

# Obtaining configuration
$configuration = showConfig

# Obtaining at risk users
$failed = endangeredUsers $configuration.Days

# Sending at risk users as email
SendAlertEmail ($failed | Select-Object Name, Count | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)



