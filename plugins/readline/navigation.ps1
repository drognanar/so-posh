if (($null -eq (Get-Module "PSReadline" -ErrorAction SilentlyContinue)) -or ($script:SoPoshPlugins -notcontains 'readline')) {
  return
}

<#
.SYNOPSIS
  Automatically perform `cd path` command just by entering `path`.

.DESCRIPTION
  This script improves navigation in PowerShell:
  1) It allows to cd into folders just by typing the folder name (`~/Documents`)
  2) It allows to go to previous/next/parent directory by pressing Ctrl+[ Ctrl+] Ctrl+\

  Function that allows to cd into folders by typing `directory/`
  The completion triggers only if an invalid command was entered.
  Typing `~/Documents/` will execute `cd ~/Documents/`
#>
function AutoCompleteCd($isCommandToken, $commandTokenCandidate, $tokens) {
  $potentialPath = Get-PSReadlineTokenValue $commandTokenCandidate
  $isFinalToken = $tokens[-1] -eq $commandTokenCandidate -or $tokens[-2] -eq $commandTokenCandidate
  if ([string]::IsNullOrEmpty($potentialPath) -or -not $isFinalToken) {
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

Set-PSReadlineKeyHandler -BriefDescription SetPreviousLocation `
                         -LongDescription 'Change directory to previous location' `
                         -Key Ctrl+[ `
                         -ScriptBlock { Set-LocationEx -;  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()  }

Set-PSReadlineKeyHandler -BriefDescription SetNextLocation `
                         -LongDescription 'Change directory to next location' `
                         -Key Ctrl+] `
                         -ScriptBlock { Set-LocationEx +;  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()  }

Set-PSReadlineKeyHandler -BriefDescription SetParentLocation `
                         -LongDescription 'Change directory to parent location' `
                         -Key Ctrl+\ `
                         -ScriptBlock { Set-LocationEx ..; [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt() }

Set-PSReadlineKeyHandler -BriefDescription GetLocationStack `
                         -LongDescription 'Show history of visited directories' `
                         -Key Ctrl+Shift+\ `
                         -ScriptBlock { Invoke-Shortcut cd }
