. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
clear


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "0 - List Endangered Users`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 
    clear

    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        if (checkUser -uName $name) # if username already exists returns user to main menu
        {
            Write-Host ("User already Exists" | Out-String)
            Continue
        }
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        if (-not (checkPassword -pass $password)) # If password does not meet criteria, returns user to main menu
        {
            Write-Host ("Password must contain alphanumeric characters, special characters, and must be at least 6 digits long" | Out-String)
            Continue
        }

        # DONE: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
            
        # DONE: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
       

        
        # DONE: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true

        # Done: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # DONE: Check the given username with the checkUser function.
        if (checkUser -uName $name)
        {
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else
        {
            Write-Host ("Username not found." | Out-String)
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # DONE: Check the given username with the checkUser function.
         if (checkUser -uName $name)
        {
            enableAUser $name
            Write-Host ("User: $name Enabled." | Out-String)
           
        }
        else
        {
            Write-Host("Username not found." | Out-string)
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # DONE: Check the given username with the checkUser function.
        if (checkUser -uName $name)
        {
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else
        {
            Write-Host("Username not found." | Out-string)
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # DONE: Check the given username with the checkUser function.
        if (checkUser -uName $name)
        {
            Write-Host ("How many days back?" | Out-String)
            $days = Read-Host
            if (-not $days -match '^[1-9][0-9]*$')
            {
                $days = 0
                continue
                
            }
            $userLogins = getLogInAndOffs $days
        }
        else
        {
            Write-Host ("Username not found." | Out-String)
        }

        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
       
        if (checkUser -uName $name)
        {
            Write-Host ("How many days?" | Out-String)
            $days = Read-Host
            if (-not $days -match '^[1-9][0-9]*$')
            {
                $days = 0
                continue
                
            }
            $userLogins = getFailedLogins $days
        }
        else
        {
            Write-Host ("Username not found." | Out-String)
        }
        # DONE: Check the given username with the checkUser function.

       
        # Done: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 0){
        
        # Prompt user 
        Write-Host ("How many days?" | Out-String)
        $days = Read-Host
        if (-not $days -match '^[1-9][0-9]*$')
            {
                $days = 0
                continue
                
            }

        # Gater data and store it 
        $userLogins = getFailedLogins $days
        $atRiskUsers = $userLogins | Where-Object {$_.FailedLoginCount -gt 10}

        # Print table
        Write-Host ($atRiskLogins | Format-Table | Out-String)
          
    # Done: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    }

    else{
    # DONE: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    
    Write-Host ("Please enter a choice 0-9." | Out-String)
    }
}




