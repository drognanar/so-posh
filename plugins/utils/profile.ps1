# This script defines shortcuts for reloading and editing profile.

<#
.SYNOPSIS
  Reloads the current user's profile.
#>
function Update-Profile() {
  $global:USERPROFILE = $true
  Invoke-Shortcut '. $PROFILE'
}

<#
.SYNOPSIS
  Opens the profile folder in the default text editor.
#>
function Edit-Profile() {
  & $env:EDITOR $PROOT
}

Set-PSReadlineKeyHandler -BriefDescription UpdateProfile `
                         -LongDescription 'Reloads the powershell profile' `
                         -Key Ctrl+Shift+r -ScriptBlock { Update-Profile }

Set-PSReadlineKeyHandler -BriefDescription UpdateProfile `
                         -LongDescription 'Reloads the powershell profile' `
                         -Key F5 -ScriptBlock           { Update-Profile }

Set-PSReadlineKeyHandler -BriefDescription EditProfile `
                         -LongDescription 'Opens a text editor with profile directory' `
                         -Key Ctrl+Shift+e -ScriptBlock { Edit-Profile }

Set-PSReadlineKeyHandler -BriefDescription EditProfile `
                         -LongDescription 'Opens a text editor with profile directory' `
                         -Key F12 -ScriptBlock          { Edit-Profile }
