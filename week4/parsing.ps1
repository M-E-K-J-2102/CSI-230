clear
function ApacheLogs1()
{
    $logsNotFormatted = Get-Content -Path C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for ($i = 0; $i -lt $logsNotFormatted.count; $i++)
    {
        # Split a string into words
        $words = $logsNotFormatted[$i].split(" ");
        $tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                            "Time" = $words[3].Trim('[');
                                            "Method" = $words[5].Trim('"');
                                            "Page" = $words[6];
                                            "Protocol" = $words[7];
                                            "Response" = $words[8];
                                            "Referrer" = $words[10];
                                            "Client" = $words[11..($words.count - 1)];}
    }
    return $tableRecords | Where-object {$_.IP -like "10.*"}
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -Autosize -Wrap