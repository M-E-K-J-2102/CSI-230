clear
function sendAlertEmail ($body)
{
    $from = "matthew.kanejimenez@mymail.champlain.edu"
    $to = "matthew.kanejimenez@mymail.champlain.edu"
    $subject = "Suspicious Activity" 

    $password = "cxai jheb tnea vikt" | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $from, $password

    Send-MailMessage -From $from -To -$to -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $credential
}

 sendAlertEmail "Body of Email"
