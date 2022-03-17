$SitesToBlock = “play-cs.com”,”yaplakal.ru”,”9gag.com”
$IPAddress = $SitesToBlock | Resolve-DnsName -NoHostsFile | Select-Object -ExpandProperty IPAddress
New-NetFirewallRule -DisplayName "Block Web Sites" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress $IPAddress