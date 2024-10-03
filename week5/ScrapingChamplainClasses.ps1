function gatherClasses ()
{
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.43/Courses-1.html

    # Get all tr elements of the HTML document
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    # Create empty array to hold results
    $fullTable = @()
    # Iterate through every tr element
    for ($i = 1; $i -le $trs.length; $i++)
    {
       
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        # Want to seperate start time and end time from one time field
        $times = $tds[5].innerText -split "-"

        $fullTable += [pscustomobject] @{"Class Code" = $tds[0].innerText.Trim();`
                                         "Title"      = $tds[1].innerText.Trim();`
                                         "Days"       = $tds[4].innerText.Trim();`
                                         "Time Start" = $Times[0];`
                                         "Time end"   = $Times[1];`
                                         "Instructor" = $tds[6].innerText.Trim();`
                                         "Location"   = $tds[9].innerText.Trim();`
                                        }
    }
    return $fullTable
}
clear


function daysTranslator($fullTable)
{
    # Go over every record in fullTable
    for ($i = 0; $i -lt $fullTable.length; $i++)
    {
        # Empty array to hold days for every record
        $days = @()

        #If you see "M" = Monday
        if ($fullTable[$i].Days -ilike "*M*") {$days += "Monday"}
        # If you see "T" followed by T,W, or F = Tuesday
        if ($fullTable[$i].Days -ilike "*T[TWF]*") {$days += "Tuesday"}
        # If you only see one "T" = Tuesday
        ElseIf ($fullTable[$i].Days -ilike "T") {$days += "Tuesday"}
        # If you see "W" = Wednesday
        if ($fullTable[$i].Days -ilike "*W*") {$days += "Wednesday"}
        # If you see "TH" = Thursday
        if ($fullTable[$i].Days -ilike "*Th*") {$days += "Thursday"}
        # If you see "F" = Friday
        if ($fullTable[$i].Days -ilike "*F*") {$days += "Friday"}
        
        # Make the switch
        $fullTable[$i].Days = $days
        }
    return $fullTable
}

