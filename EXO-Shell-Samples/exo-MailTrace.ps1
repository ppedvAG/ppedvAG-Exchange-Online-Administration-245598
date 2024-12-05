Get-MessageTrace -SenderAddress admin@M365xxxxxx.onmicrosoft.com -StartDate (Get-Date).AddHours(-1) -EndDate (Get-Date) -Status Delivered

Get-MessageTrace  -Start "Jan 16 2024” -EndDate (Get-Date)| select-object eventid,timestamp,source,messageid,sender,recipients,messagesubject | Out-Gridview