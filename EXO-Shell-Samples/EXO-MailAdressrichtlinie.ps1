New-EmailAddressPolicy -Name "Firma" -IncludedRecipients MailboxUsers -ConditionalStateorProvince "NRW","Hessen","Berlin" -EnabledEmailAddressTemplates "SMTP:%s%2g@M365x93469271.onmicrosoft.com"

#New-EmailAddressPolicy -Name "<Policy Name>" <Precanned recipient filter | Custom recipient filter> [-RecipientContainer <OrganizationalUnit>] [-Priority <AllowedInteger>] -EnabledEmailAddressTemplates "SMTP:<PrimaryEmailAddressFormat>","smtp:<ProxyEmailAddress1>","smtp:<ProxyEmailAddress2>"...

#New-EmailAddressPolicy -Name "Northwest Executives" -RecipientFilter "(RecipientType -eq 'UserMailbox') -and (Title -like '*Director*' -or Title -like '*Manager*') -and (StateOrProvince -eq 'WA' -or StateOrProvince -eq 'OR' -or StateOrProvince -eq 'ID')" -EnabledEmailAddressTemplates "SMTP:%2g%s@contoso.com" -Priority 2

#Get-EmailAddressPolicy | Format-List Name,Priority,Enabled*,RecipientFilterType,RecipientContainer,RecipientFilter,IncludedRecipients,Conditional*

#Update-EmailAddressPolicy -Identity "Northwest Executives"

#Update-EmailAddressPolicy -Identity <EmailAddressPolicyIdentity> [-FixMissingAlias] -[UpdateSecondaryAddressesOnly]