# Add an Import-Module statement to profile if one is missing.
function Add-PoshModuleToProfile($ModuleName) {
    $profileContent = Get-Content $PROFILE -Raw
    if ($profileContent -notmatch "Import-Module $ModuleName") {
        "`nRemove-Module $ModuleName -ErrorAction SilentlyContinue" | Add-Content $PROFILE
        "Import-Module $ModuleName -DisableNameChecking" | Add-Content $PROFILE
    }
}

# Creates a posh module directory.
# Adds it to be loaded by userprofile.ps1.
function New-PoshModule($ModuleName) {
    $moduleTemplatePath = Join-Path $PSScriptRoot '../../profile/templates/module'
    $moduleDir = "$PROOT\Modules\$ModuleName"
    $initPath = Join-Path $moduleDir 'init.psm1'
    $modulePath = Join-Path $moduleDir "$ModuleName.psm1"

    if (-not [System.IO.Directory]::Exists($moduleDir)) {
        Copy-Item -Recurse $moduleTemplatePath $moduleDir
        Move-Item $initPath $modulePath
        Add-PoshModuleToProfile $ModuleName
        Import-Module $ModuleName
    }
}
