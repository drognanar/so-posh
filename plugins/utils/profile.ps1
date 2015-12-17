# This script defines shortcuts for reloading and editing profile.

# A script that reloads the current user's profile.
function Update-Profile() {
    $global:USERPROFILE = $true
    Invoke-Shortcut '. $PROFILE'
}

function Edit-Profile() {
    & $env:EDITOR $PROOT
}

Set-PSReadlineKeyHandler -Key Ctrl+Shift+r -ScriptBlock { Update-Profile }
Set-PSReadlineKeyHandler -Key F5 -ScriptBlock           { Update-Profile }
Set-PSReadlineKeyHandler -Key Ctrl+Shift+e -ScriptBlock { Edit-Profile }
Set-PSReadlineKeyHandler -Key F12 -ScriptBlock          { Edit-Profile }
