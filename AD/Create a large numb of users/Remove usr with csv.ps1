
### Remove the users created in the recipe

$users = Import-Csv C:\PS\users.csv
foreach ($User in $Users)
{
  Get-ADUser -Identity $user.Alias | remove-aduser
}