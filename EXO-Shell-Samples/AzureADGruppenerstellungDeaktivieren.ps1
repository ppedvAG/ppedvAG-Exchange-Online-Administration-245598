Get-InstalledModule -Name "AzureAD*"
Install-Module AzureADPreview

Connect-AzureAD  

####erst im AdminCenter eine SecurityGroup anlegen und Namen in Zeile 8 eintragen

$GroupName = "IchDarfGruppenErstellen"
$AllowGroupCreation = "False"

Connect-AzureAD

try
    {
        $template = Get-AzureADDirectorySettingTemplate | ? {$_.displayname -eq "group.unified"}
        $settingsCopy = $template.CreateDirectorySetting()
        New-AzureADDirectorySetting -DirectorySetting $settingsCopy
        $settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
    }
catch
    {
        $settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id       
    }

$settingsCopy = Get-AzureADDirectorySetting -Id $settingsObjectID

$settingsCopy["EnableGroupCreation"] = $AllowGroupCreation

If ($GroupName -eq "")
    {
        $SettingsCopy["GroupCreationAllowedGroupId"] = ""
    }
Else
    {
        $SettingsCopy["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $GroupName).objectid
    }

Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $settingsCopy

(Get-AzureADDirectorySetting -Id $settingsObjectID).Values