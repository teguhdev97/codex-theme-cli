$ErrorActionPreference = 'Stop'
$source = $PSScriptRoot
if (-not (Test-Path (Join-Path $source 'codex.exe'))) {
    throw 'Extract the release ZIP first, then run this installer from that folder.'
}
$destination = Join-Path $env:LOCALAPPDATA 'CodexAzure\bin'
New-Item -ItemType Directory -Force $destination | Out-Null
Get-ChildItem $source -Filter '*.exe' | Copy-Item -Destination $destination -Force
$fragmentDir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows Terminal\Fragments\CodexAzure'
New-Item -ItemType Directory -Force $fragmentDir | Out-Null
$fragmentPath = Join-Path $fragmentDir 'theme.json'
if (Test-Path $fragmentPath) {
    Copy-Item $fragmentPath ($fragmentPath + '.backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss')) 
}
$fragment = @{
    profiles = @(
        @{
            guid = '{6f880367-9c40-456f-bc15-d4818b4fc0eb}'
            name = 'Codex Azure Custom'
            commandline = '"' + (Join-Path $destination 'codex.exe') + '" --no-alt-screen'
            startingDirectory = '%USERPROFILE%'
            colorScheme = 'Codex Azure Custom'
            adjustIndistinguishableColors = 'always'
            font = @{ face = 'Cascadia Mono'; size = 11 }
            opacity = 100
            useAcrylic = $false
        },
        @{
            guid = '{b90b4f7e-7997-47ee-baa6-089d7d5db706}'
            name = 'PowerShell Azure'
            commandline = 'powershell.exe -NoLogo'
            startingDirectory = '%USERPROFILE%'
            colorScheme = 'Codex Azure Custom'
            adjustIndistinguishableColors = 'always'
            font = @{ face = 'Cascadia Mono'; size = 11 }
        }
    )
    schemes = @(
        @{
            name = 'Codex Azure Custom'
            background = '#4237CF'; foreground = '#A9D4FF'
            cursorColor = '#FFFFFF'; selectionBackground = '#7068DF'
            black = '#211B65'; brightBlack = '#FFFFFF'
            red = '#FFB9C5'; brightRed = '#FFD3DB'
            green = '#B5F4CE'; brightGreen = '#DAFFE7'
            yellow = '#FFE49A'; brightYellow = '#FFF0BE'
            blue = '#A9D4FF'; brightBlue = '#D0E7FF'
            purple = '#E2BFFF'; brightPurple = '#F0DBFF'
            cyan = '#9DF1F5'; brightCyan = '#D0FCFF'
            white = '#FFFFFF'; brightWhite = '#FFFFFF'
        }
    )
}
$json = $fragment | ConvertTo-Json -Depth 8
[IO.File]::WriteAllText($fragmentPath, $json, (New-Object Text.UTF8Encoding($false)))
Write-Host 'Installed. Restart Windows Terminal and select Codex Azure Custom or PowerShell Azure.'
Write-Host "To remove the theme profiles, delete: $fragmentDir"
Write-Host "Custom binaries: $destination"
