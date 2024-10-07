. (Join-Path $PSScriptRoot "ScrapingChamplainClasses.ps1")

clear
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.43/ToBeScraped.html

# Get a count of the links in the page
$scraped_page.Links.Count
clear
# Display links as an html element
$scraped_page.Links
clear
# Display only URL and its text
$scraped_page.Links | Select outerText, href
clear
# Get outer text for every element with h2 tag
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select outerText
$h2s
clear
# Print inner text of every div element that has the class div-1
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where {$_.getAttributeNode("class").Value`
-ilike "div-1"} | Select innerText
$divs1
clear
# GatherClasses
$courses = gatherClasses
# Change the weekday letter to full weekday name
$courses = daysTranslator -fullTable $courses

# List all the courses of instructor Furkan Paligu
$courses | Select-Object "Class Code", Instructor, Location, Days,`
 "Time Start", "Time End" | Where-Object{$_."Instructor" -like "Furkan Paligu"}
 clear
# List all courses in Joyce 310 on mondays, only dispay class code and times 
$courses | Where-Object{($_."Days" -like "Monday") -and ($_."Location" -like "Joyc 310")}`
 | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"
 clear 
 # Make a list of all instructors that teach at least one course in
 # SYS, SEC, NET, FOR, CSI, DAT. Sort by name and make it unique
$its = $courses | Where-Object { ( $_."Class Code" -like "SYS*") -or`
                                 ( $_."Class Code" -like "NET*") -or`
                                 ( $_."Class Code" -like "FOR*") -or`
                                 ( $_."Class Code" -like "CSI*") -or`
                                 ( $_."Class Code" -like "DAT*")}`
                    | Select-Object "Instructor" | Sort-Object "Instructor" -Unique
$its
clear
# Group all the instructors by the number of classes they are teaching,
# Sort by the number of classes they are teaching
$courses | Where {$_.Instructor -in $its.Instructor} | Group-Object "Instructor" |`
 Select-Object Count, Name | Sort-Object Count -Descending
