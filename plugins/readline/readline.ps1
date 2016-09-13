if ($null -eq (Get-Module "PSReadline" -ErrorAction SilentlyContinue)) {
  return
}

function Get-PSReadlineTokens {
  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)
  return $tokens
}

function Test-PSReadlineCommandToken($Token) {
  $isString = $Token.Kind -eq "StringExpandable"
  $isCommand = $Token.TokenFlags.HasFlag([System.Management.Automation.Language.TokenFlags]::CommandName)
  if ($isCommand -or $isString) {
    $tokenValue = Get-PSReadlineTokenValue $Token
    $command = Get-Command $tokenValue -ErrorAction SilentlyContinue
    if ($command -ne $null) { return $true }
    $resolvedPath = Resolve-Path $tokenValue -ErrorAction SilentlyContinue
    if ($resolvedPath -eq $null) { return $false }
    $command = Get-Command $resolvedPath -ErrorAction SilentlyContinue
    if ($command -ne $null) { return $true }
    return $false
  }

  return $false
}

function Get-PSReadlineCommandTokenCandidate($Tokens) {
  if ($Tokens.Length -eq 0) {
    return $null
  }

  $isAmpersand = $Tokens[0].TokenFlags.HasFlag([System.Management.Automation.Language.TokenFlags]::SpecialOperator) -and $Tokens[0].Kind -eq "Ampersand"
  if ($Tokens.Length -gt 1 -and $isAmpersand) {
    return $Tokens[1]
  } else {
    return $Tokens[0]
  }
}

function Get-PSReadlineTokenValue($Token) {
  if ($Token.value) { return $Token.value } else { return $Token.text }
}

# Gets the command that is being entered via readline.
# 1) `command`
# 2) `& "command"`
function Invoke-PoshReadlineHandlers {
  $tokens = Get-PSReadlineTokens
  $commandTokenCandidate = Get-PSReadlineCommandTokenCandidate $tokens
  $isCommandToken = Test-PSReadlineCommandToken $commandTokenCandidate

  foreach ($transformer in $global:PoshReadlineHandlers) {
    $transformCompleted = . $transformer $isCommandToken $commandTokenCandidate $tokens
    if ($transformCompleted) {
      break
    }
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

function Invoke-Shortcut($Code, [switch]$AddCurrentLineToHistory, [switch]$SkipAcceptLine) {
  if ($AddCurrentLineToHistory) {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($cursor)
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($Code)

  if (-not $SkipAcceptLine) {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
}

$global:PoshReadlineHandlers = @()

# Set a keyboard shortcut that executes readline handlers.
Set-PSReadlineKeyHandler -BriefDescription AcceptRewriteLine `
                         -LongDescription 'Perform readline rewrites and accept line' `
                         -Key Enter `
                         -ScriptBlock { Invoke-PoshReadlineHandlers }

# And a keyboard shortcut that does not execute readline handlers.
Set-PSReadlineKeyHandler -Key Ctrl+Enter AcceptLine
