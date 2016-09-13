An Oh-My-Zsh inspired set of dotfiles for PowerShell (PoSh).

# Summary of features

* Navigation
    * `z` - navigate to a directory anywhere on disk matching that name using [Jump.Location](https://github.com/tkellogg/Jump-Location)
    * Enter `folder/` to cd into that folder (instead of having to type `cd folder`)
    * Go to previous folder with `Ctrl+[`
    * Go to next folder with `Ctrl+]`
    * Go to parent folder with `Ctrl+\`
* Notifications
    * `New-Notification` - create a tooltip notification
    * Automatically notify when long running commands complete
* Git
    * `New-Gitignore` - create gitignore files (based on [gitignore.io](http://gitignore.io))
    * `Get-PR` - fetch a PR from github
* Readline
    * Run files with shebang by entering a filename
    * `Set-ActiveTheme` - specify a theme used to generate a prompt
    * `Register-Theme` - register a new prompt theme
* Utilities
    * `Invoke-InDir` - execute a command in a specific directory
    * `Invoke-Shortcut` - type in a specific command into prompt and press enter
    * `Show-CommandDetails` - show command definition. If no parameters given displays all commands
    * `Update-Profile` - reload dotfiles. Bound to: `Ctrl+Shift+R` and `F5`
    * `Edit-Profile` - edit dotfiles. Bound to `Ctrl+Shift+E` and `F12`
* VsCode
    * `Invoke-VsCode` - starts vscode by default reusing the existing window
* Additional modules included
    * pscx - many additional helper functions
    * Jump.Location - efficient `cd` between directories
    * Posh-Git - powershell git integration

# Create your own dotfiles

To create your own dotfiles just run `New-SoPoshModule <name>` command.
This will create a new module under `~\Documents\WindowsPowerShell\Modules\<name>` which will load any `.ps1` files under that path of powershell startup.

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

# Themes

# Settings

* `$global:SoPoshAutoloadModules` - automatically loads the following modules on PowerShell startup
* `$global:SoPoshPlugins` - loads the following so-posh powershell scripts. By default lists all so-posh scripts.
* `$global:SoPoshActiveTheme` - theme with which powershell will start
* `$global:SoPoshVisualStudioVersion` - visual studio version for which to load enviornment variables
* `$global:SoPoshLastCommandNotificationTimeout` - timeout in seconds after which to notify of long running commands
* `$global:SoPoshInteractiveCommands` - lists commands for which notifications should not be created
