clear
# Q1: Get name of every process whose name starts with 'C'
Get-Process | Where-Object {$_.Name -ilike "C*"} | Select ProcessName, CPU, Path, Handles | Out-String

# Q2: List all processes where the path does not include "System32"
Get-Process | Where-Object {$_.Path -inotlike "*System32*"} | Select ProcessName, CPU, Path, Handles

# Q3: List every Stopped service, order it alphabetically, and save it to a CSV file
Get-Service | Where-Object{$_.Status -eq "Stopped"} | Sort-Object | Export-Csv -Path `
C:\Users\champuser\Desktop\Assignments\"Assignment 1"\ClosedProgramms.csv
Get-Service | Select *

#Q4 Starts an instance of Chrome and directs it to champlain's website. 
#If an instance is already running, it stops it
$Browser = Get-Process -name "Chrome"

if ($Browser)
{
    Stop-Process -name "Chrome"
}  
else
{  
   Start-Process -FilePath Chrome.exe '--new-window https://www.champlain.edu'
}