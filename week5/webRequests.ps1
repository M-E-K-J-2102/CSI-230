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