$bioschar = DATA {ConvertFrom-StringData -StringData @'       
2 = Unknown
3 = BIOS Characteristics Not Supported
4 = ISA is supported
5 = MCA is supported
6 = EISA is supported
7 = PCI is supported
8 = PC Card (PCMCIA) is supported
9 = Plug and Play is supported
10 = APM is supported
11 = BIOS is Upgradable (Flash)
15 = Boot from CD is supported
33 = USB Legacy is supported
'@}
function get-biosinfo {                               
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
    [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
 Get-WmiObject -Class Win32_Bios -ComputerName $computername |                                  
 Select-Object  BuildNumber, CurrentLanguage, InstallableLanguages,
 Manufacturer, Name, PrimaryBIOS,
 @{Name="Release Date";
 Expression={ $_.ConvertToDateTime( $_.ReleaseDate) }},
 SerialNumber, SMBIOSBIOSVersion, SMBIOSMajorVersion,
 SMBIOSMinorVersion, SMBIOSPresent, Status, Version
 "BIOS Characteristics:"                                    
 Get-WmiObject -Class Win32_Bios -ComputerName $computername |
 Select-Object -ExpandProperty BiosCharacteristics |
 foreach-Object {$bioschar["$($_)"]}
}}