Install-Module ExchangeOnlineManagement 

Connect-ExchangeOnline

Set-ExecutionPolicy RemoteSigned


Get-EXOMailbox

Add-MailboxFolderPermission -Identity konferenzraum1:\calendar -User irvins@M365x93469271.onmicrosoft.com -AccessRights Publishingeditor

Get-MailboxFolderPermission -Identity konferenzraum1:\calendar | ft user,accessrights

Set-CalendarProcessing 


Get-EXOMailboxStatistics -Identity admin@M365x93469271.onmicrosoft.com,irvins@M365x93469271.onmicrosoft.com

Get-EXOMailbox | Get-EXOMailboxStatistics |sort totalitemsize -Descending | ft displayname,itemcount,totalitemsize

Get-Mailbox

Get-EXOMailbox | Get-MailboxPermission | where {$_.user -eq "admin@M365x93469271.onmicrosoft.com"} | fl

Add-MailboxPermission -Identity adelev -AccessRights fullaccess -User "ichdarfgruppenerstellen"


Get-EXOMailboxPermission -Identity adelev

Get-EXOMailbox | Get-MailboxPermission | where {$_.user -eq "IchDarfGruppenErstellen"} | ft 


Get-EXOMailbox -Identity "7e2b2101-92d3-462b-a201-ae57c0aff0ae"

Get-Mailbox | Remove-MailboxPermission | where {$_.user -eq "IchDarfGruppenErstellen"}

Get-EXOMailbox | Get-MailboxPermission | where {$_.user -eq "IchDarfGruppenErstellen"} | Remove-MailboxPermission 

Remove-MailboxPermission -Identity adelev -AccessRights fullaccess -user Ichdarfgruppenerstellen     #| where {$_.user -eq "IchDarfGruppenErstellen"}


Get-EXOMailbox | Remove-MailboxPermission -AccessRights fullaccess -User Ichdarfgruppenerstellen -verbose

Get-EXOMailbox |Add-MailboxPermission -AccessRights fullaccess -User "ichdarfgruppenerstellen"


get-command *mailbox*

get-help set-CASMailbox -Detailed

Get-Mailbox | Set-Mailbox -MaxSendSize 15MB

Add-MailboxPermission -Identity -User -AccessRights fullaccess -AutoMapping:$false


New-EmailAddressPolicy -Name "Firma" -IncludedRecipients MailboxUsers -ConditionalStateorProvince "NRW","Hessen","Berlin" -EnabledEmailAddressTemplates "SMTP:%1g.%s@M365x93469271.onmicrosoft.com"
