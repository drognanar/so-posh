if (($null -eq (Get-Module "PSReadline" -ErrorAction SilentlyContinue)) -or ($script:PoshPlugins -notcontains 'readline')) {
    return
}

<#
.SYNOPSIS
    Execute `ruby ./file` just by entering `./file` for a file which contains `#!/bin/ruby`

.DESCRIPTION
    This script allows to execute a script if it contains a shebang
    just by typing the script path.

    Run the command if file file starts with a shebang.
    For instance given file bin/a.rb
    ```
    #!ruby
    puts 'Hello World'
    ```
    Typing `cd bin; ./a.rb` execute `ruby ./a.rb`
    Typing `cd bin; a.rb` will not execute `ruby a.rb`
    Typing `bin/a.rb` will execute `ruby bin/a.rb`
#>
function AutoRunShebang($isCommandToken, $command) {
    if (-not $isCommandToken) {
        return $false
    }

    $potentialPath = Get-PSReadlineTokenValue $command
    $isApplication = $command.CommandType -eq "Application"
    $isSamePath = $command.Source -eq (Resolve-Path $potentialPath).Path
    $isEqualCommand = $command.Name -eq $potentialPath
    if (-not $isApplication -or -not $isSamePath -or $isEqualCommand) {
        return $false
    }

    # Detect the #! line.
    $firstLine = (Get-Content (Resolve-Path $potentialPath))[0]
    $isShebangCommand = $firstLine -match "#!(.*)"
    if (-not $isShebangCommand) {
        return $false
    }

    # Replace /usr/bin/app with app.
    $shebangCommand = $matches[1]
    $isEnvShebangCommand = $shebangCommand -match "/usr/bin/(.*)"
    if ($isEnvShebangCommand) {
        $shebangCommand = $matches[1]
    }

    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $command.extent.StartOffset, "$shebangCommand ")
    return $true
}

$global:PoshReadlineHandlers += { AutoRunShebang @args }