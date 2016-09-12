An Oh-My-Zsh inspired set of dotfiles for PowerShell (PoSh).

# Features

## Navigation
* Navigate directories without having to type `cd`
* Go to previous folder with `Ctrl+[`
* Go to next folder with `Ctrl+]`
* Go to parent folder with `Ctrl+\`

## Notifications
* Create notifications with `New-Notification`
* Automatically notify of long running commands

## Git
* Create gitignore files using `New-Gitignore` (based on [gitignore.io](http://gitignore.io))

## Readline
* Run files with shebang by entering a filename
* Execute a command in a directory using `Invoke-InDir`
* Themes

## Profile
* Reload dotfiles with `Ctrl+Shift+R` or `Update-Profile`
* Edit dotfiles with `Ctrl+Shift+E` or `Edit-Profile`

## Additional modules included
* pscx - many additional helper functions
* Jump.Location - efficient `cd` between directories
* Posh-Git - powershell git integration

# Create your own dotfiles

To create your own dotfiles just run `New-SoPoshModule <name>` command.
This will create a new module under `~\Documents\WindowsPowerShell\Modules\<name>`.

# Installation

```powershell
$PROOT = [System.IO.Path]::GetDirectoryName($PROFILE)
git clone https://github.com/drognanar/so-posh $PROOT/Modules/so-posh
. $PROOT/Modules/so-posh/install.ps1
```


> NOTE: You have to set execution policy to RemoteSigned in order to run the fetched dotfiles (run `Set-ExecutionPolicy RemoteSigned` when running powershell as administrator).

By default plugins are not loaded in order to minimize startup time (especially since $PROFILE is loaded when any powershell script starts).
If you wish to start modules automatically set `$global:USERPROFILE = $true` in $PROFILE.
Or, you should create a shortcut for powershell that invokes `powershell -NoExit "%userprofile%\Documents\WindowsPowerShell\userprofile.ps1"`.

# Settings

