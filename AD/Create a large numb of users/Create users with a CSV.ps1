# Recipe 3.3 - Adding Users to Active Directory using a CSV File

# 0. Create CSV
$CSVDATA = @'
Firstname, Lastname, UserPrincipalName, Alias, Password
Иван,Иванов, i.ivanov, i.ivanov, sYg#IgV@
Федор, Федоров, f.fedorov, f.fedorov, ~Yg#IgV@
Григорий, Григорьев, g.grigoriev, g.grigoriev, sYg#IgV@
'@
$CSVDATA | Out-File -FilePath C:\PS\Users.Csv

# 1. Import a CSV file containing the details of the users you 
#    want to add to AD:
$Users = Import-CSV -Path C:\PS\Users.Csv | 
  Sort-Object  -Property Alias
$users | Sort-Object -Property Alias |Format-Table

# 2. Add the users using the CSV
ForEach ($User in $Users) {
#    Create a hash table of properties to set on created user
$Prop = @{}
#    Fill in values
$Prop.GivenName         = $User.Firstname
#$Prop.Initials          = $User.Initials
$Prop.Surname           = $User.Lastname
$Prop.UserPrincipalName =
  $User.UserPrincipalName+"@azadmin.info"
$Prop.Displayname       = $User.firstname.trim() + " " + $user.lastname.trim()
#$Prop.Description       = $User.Description
$Prop.Name              = $User.firstname.trim() + " " + $user.lastname.trim()
$Prop.SamAccountName = $User.Alias
$PW = ConvertTo-SecureString -AsPlainText $user.password -Force
$Prop.AccountPassword   = $PW
#    To be safe!
$Prop.ChangePasswordAtLogon = $false
#    Now create the user
New-ADUser @Prop -Path 'OU=Users,OU=Sales,DC=azadmin,DC=info' -Enabled:$true -PasswordNeverExpires:$true
#   Finally, display user created
"Created $($Prop.Displayname)"
}

