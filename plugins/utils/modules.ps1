<#
.SYNOPSIS
  Add an Import-Module statement for a particular module to $Profile if one is missing.
#>
function Add-PoshModuleToProfile($ModuleName) {
  $profileContent = Get-Content $PROFILE -Raw
  if ($profileContent -notmatch "Import-Module $ModuleName") {
    "`nRemove-Module $ModuleName -ErrorAction SilentlyContinue" | Add-Content $PROFILE
    "Import-Module $ModuleName -DisableNameChecking" | Add-Content $PROFILE
  }
}

<#
.SYNOPSIS
  Creates a new posh module.

.DESCRIPTION
  Creates a directory under ~\Documents\WindowsPowerShell\Modules that
  contains a new module. The module is loaded and added to $PROFILE.

  New functionality can be loaded on profile startup by creating ps1 files,
  since the module definition loads all ps1 files in the directory.

#>
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
