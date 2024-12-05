#install module for all users on pc (once)
Install-Module ExchangeOnlineManagement # -Verbose -Scope AllUsers -Force
#import module 
Import-Module ExchangeOnlineManagement 
#connecto to exchange online (admin credentials needed)
Connect-ExchangeOnline 

# Nach Groesse sortieren
Get-EXOMailbox | Get-EXOMailboxStatistics | sort totalitemsize -Descending | ft displayname,totalitemsize