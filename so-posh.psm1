. "$PSScriptRoot\settings.ps1"

# Import all autoloaded modules.
$script:PoshAutoloadModules | % {
  if ($_ -is [Hashtable]) {
    $moduleName = $_.Name
    $modulePrefix = $_.Prefix
  } else {
    $moduleName = $_
    $modulePrefix = ""
  }

  Write-Verbose "Importing module $moduleName"
  Import-Module $moduleName -Global
}

# Loads a single plugin.
function Import-PoshPlugin($plugin) {
  if ("" -eq [System.IO.Path]::GetDirectoryName($plugin)) {
    $plugin = "$plugin\$plugin"
  }

  $scriptPath = Join-Path $PSScriptRoot "plugins\$plugin.ps1"
  Write-Verbose "Loading plugin at $scriptPath"
  if ([System.IO.File]::Exists($scriptPath)) {
    . $scriptPath
  }
}

# Import all autoloaded plugins.
try {
  pushd $PSScriptRoot
  foreach ($plugin in $script:PoshPlugins) {
    . Import-PoshPlugin $plugin
  }
} finally {
  popd
}

Export-ModuleMember `
  -Function @(
    ':1234'
    ':3000'
    ':3001'
    ':80'
    ':8000'
    ':8888'
    'Add-PoshModuleToProfile'
    'Edit-Profile'
    'Get-PR'
    'Invoke-Devenv'
    'Invoke-ILdasm'
    'Invoke-InDir'
    'Invoke-MSBuild'
    'Invoke-Shortcut'
    'Move-EnvPathVariable'
    'New-Gitignore'
    'New-Notification'
    'New-PoshModule'
    'New-SuccessNotification'
    'Register-Theme'
    'Remove-EnvPathDuplicates'
    'Remove-EnvPathVariable'
    'Set-ActiveTheme'
    'Update-PR'
    'Update-Profile'
  ) `
  -Alias @(
    'devenv'
    'gig'
    'ildasm'
    'msbuild'
  )
