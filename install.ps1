# Installed for so-posh.
# A script that install and deploys powershell profile.
$global:PROOT = [System.IO.Path]::GetDirectoryName($PROFILE)
$SO_POSH_PROFILE_TEMPLATE_PATH = Join-Path $PSScriptRoot "profile/templates/Microsoft.PowerShell_profile.ps1"

Write-Host "Installing so-posh..."
Write-Host "> Installing modules..."
Install-Module pscx -Scope CurrentUser -AllowClobber
Install-Module Jump.Location -Scope CurrentUser -AllowClobber
Install-Module posh-git -Scope CurrentUser -AllowClobber

Write-Host "> Loading so-posh..."
Import-Module so-posh

# 3. If no profile exists create one. Create package if it does not exist yet.
Write-Host "> Creating a PowerShell profile..."
if ([System.IO.File]::Exists($PROFILE)) {
  $overwrite = $Host.UI.PromptForChoice('', 'You already have a PowerShell profile. Do you want to overwrite it?', @('&Yes', '&No'), 0)
  if ($overwrite -eq 0) {
    Copy-Item $SO_POSH_PROFILE_TEMPLATE_PATH $PROFILE
  }
} else {
  Copy-Item $SO_POSH_PROFILE_TEMPLATE_PATH $PROFILE
}

Write-Host "> Creating a home-profile folder for dotfiles..."
New-SoPoshModule 'home-profile'

Write-Host "Installed so-posh" -ForegroundColor Green
