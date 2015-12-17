if (($null -eq (Get-Module "PSReadline" -ErrorAction SilentlyContinue)) -or ($script:PoshPlugins -notcontains 'readline/navigation')) {
    return
}

# This script improves navigation in PowerShell:
# 1) It allows to cd into folders just by typing the folder name (`~/Documents`)
# 2) It allows to go to previous/next/parent directory by pressing Ctrl+[ Ctrl+] Ctrl+\

# Function that allows to cd into folders by typing `directory/`
# The completion triggers only if an invalid command was entered.
# Typing `~/Documents/` will execute `cd ~/Documents/`
function AutoCompleteCd($isCommandToken, $commandTokenCandidate, $tokens) {
    $potentialPath = Get-PSReadlineTokenValue $commandTokenCandidate
    if ([string]::IsNullOrEmpty($potentialPath) -or $tokens.Length -gt 2) {
        return $false
    }

    if (-not $isCommandToken -and -not ($potentialPath -eq $null)) {
        $existsDir = [IO.Directory]::Exists((Resolve-Path $potentialPath))
        if ($existsDir) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $commandTokenCandidate.extent.StartOffset, "cd ")
            return $true
        }
    }

    return $false
}

$global:PoshReadlineHandlers += { AutoCompleteCd @args }
Set-PSReadlineKeyHandler -Key Ctrl+[ -ScriptBlock { Invoke-Shortcut 'cd -'  }
Set-PSReadlineKeyHandler -Key Ctrl+] -ScriptBlock { Invoke-Shortcut 'cd +'  }
Set-PSReadlineKeyHandler -Key Ctrl+\ -ScriptBlock { Invoke-Shortcut 'cd ..' }