#Ask technician for the username of the person leaving

Write-Host "Welcome to the new undo offboarding Powershell Script! There is just one question" -ForegroundColor Green
$username = Read-Host -Prompt "Enter the username of the employee that was mistakenly removed"

#Grab information from AD

$ADInfo = Get-ADUser -Identity $username

#Reset account password to generic one

Set-ADAccountPassword -Identity $username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Password2022" -Force)

#Disable AD account

Enable-ADAccount -Identity $username

#Clear proxy addresses

Set-ADUser -Identity $username -Clear ProxyAddresses

#Add AD proxy addresses

Set-ADUser -Identity $username -add @{ProxyAddresses="SMTP:$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}
Set-ADUser -Identity $username -add @{ProxyAddresses="smtp:$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}
Set-ADUser -Identity $username -add @{ProxyAddresses="smtp:$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}
Set-ADUser -Identity $username -add @{ProxyAddresses="smtp:$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}

#Change mail AD address

Set-ADUser -Identity $username -Replace @{mail="$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}

#Change target AD address

Set-ADUser -Identity $username -Replace @{targetAddress="SMTP:$($ADInfo.GivenName).$($ADInfo.Surname)@********.com"}