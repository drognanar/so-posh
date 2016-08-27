$PROOT = [System.IO.Path]::GetDirectoryName($PROFILE)

# Allow to reload profile and load all modules with Ctrl+Shift+r.
function Restart-Profile {
  $global:USERPROFILE = $true
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('. $PROFILE')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

if ($null -ne (Get-Module 'PSReadline')) {
  Set-PSReadlineKeyHandler -Key Ctrl+Shift+r -ScriptBlock { Restart-Profile }
}

# Skip loading plugins if any flags/script path passed around to PowerShell.
# Skip loading plugins if $PROOT\Modules is not on the modules path.
if ($true -ne $global:USERPROFILE -and
  ((([Environment]::GetCommandLineArgs()).Length -gt 1) -or
  (($env:PSModulePath).Split(';') -notcontains "$PROOT\Modules")))
{
  return
}

# Reload the following modules.
