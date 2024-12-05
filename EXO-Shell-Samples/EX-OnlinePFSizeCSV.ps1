[string]$timestamp = (Get-Date -Format yyyy-MM-dd-HH-mm) 
###### insert path to csv export
$csvpath = "C:\pfsize\exon-stats-$timestamp.csv"
######
#install module for all users on pc (once)
Install-Module ExchangeOnlineManagement # -Verbose -Scope AllUsers -Force
#import module 
Import-Module ExchangeOnlineManagement 
#connecto to exchange online (admin credentials needed)
Connect-ExchangeOnline 
#see statistics of mailboxes
$mbs = Get-Mailbox -ResultSize Unlimited | Sort-Object name
#create an array for all statistics
$mbstats = @()
foreach($mb in $mbs){
  $dn = (($mb).identity)
  $activesync = (Get-CASMailbox -Identity "$dn").hasactivesyncdevicepartnership
  if ($activesync -eq $true){
    #fetching active sync device information
    $activesyndevice = Get-MobileDevice -Mailbox "$dn" | Select-Object DeviceType,DeviceOS,DeviceUserAgent,WhenCreated
    $devicemodel = @()
    $devicemodel = ($activesyndevice) | Select-Object DeviceType -ExpandProperty DeviceType 
    $devicemodel = $devicemodel -join '||' 
    $deviceos = @()
    $deviceos = ($activesyndevice) | Select-Object DeviceOS -ExpandProperty DeviceOS 
    $deviceos = $deviceos -join '||'
    $deviceuagent = @()
    $deviceuagent =  ($activesyndevice) | Select-Object DeviceUserAgent -ExpandProperty DeviceUserAgent
    $deviceuagent = $deviceuagent -join '||'
    $devicecreated = @()
    $devicecreated = ($activesyndevice) | Select-Object WhenCreated -ExpandProperty WhenCreated
    $devicecreated = $devicecreated -join '||'
    #putting everything together (active sync devices and mailbox statistics)
    $mbstat = Get-Mailbox -Identity "$dn" | Get-MailboxStatistics | Select-Object DisplayName,MailboxGuid,`
    @{name="TotalItemSize (MB)"; expression={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},`
    ItemCount,@{name="ActiveSync";expression={"True"}}, @{name="DeviceType";expression={"$devicemodel"}},@{name="DeviceOS";expression={"$deviceos"}},`
    @{name="DeviceAgent";expression={"$deviceuagent"}},@{name="DeviceFirstConnected";expression={"$devicecreated"}}`
    #adding to array 
    $mbstats += $mbstat
  }
  else{
    #get statistics for non active sync users
    $mbstat = Get-Mailbox -Identity "$dn" | Get-MailboxStatistics | Select-Object DisplayName,MailboxGuid, @{name="TotalItemSize (MB)"; expression={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,@{name="ActiveSync";expression={"False"}} 
    #adding to array
    $mbstats += $mbstat
  }
} 
#export information to csv with delimiter 
$mbstats | Export-Csv -Path "$csvpath" -Encoding UTF8 -Delimiter ";"