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

function Test-PSReadlineCommandToken($token) {
  $isString = $token.Kind -eq "StringExpandable"
  $isCommand = $token.TokenFlags.HasFlag([System.Management.Automation.Language.TokenFlags]::CommandName)
  if ($isCommand -or $isString) {
    $tokenValue = Get-PSReadlineTokenValue $token
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

function Get-PSReadlineCommandTokenCandidate($tokens) {
  if ($tokens.Length -eq 0) {
    return $null
  }

  $isAmpersand = $tokens[0].TokenFlags.HasFlag([System.Management.Automation.Language.TokenFlags]::SpecialOperator) -and $tokens[0].Kind -eq "Ampersand"
  if ($tokens.Length -gt 1 -and $isAmpersand) {
    return $tokens[1]
  } else {
    return $tokens[0]
  }
}

function Get-PSReadlineTokenValue($token) {
  if ($token.value) { return $token.value } else { return $token.text }
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

function Invoke-Shortcut($code, [Switch]$silent=$false) {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  if ($silent) {
    [scriptblock]::Create($code).Invoke()
  } else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($code)
  }
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

$global:PoshReadlineHandlers = @()

# Set a keyboard shortcut that executes readline handlers.
Set-PSReadlineKeyHandler -Key Enter -ScriptBlock { Invoke-PoshReadlineHandlers }

# And a keyboard shortcut that does not execute readline handlers.
Set-PSReadlineKeyHandler -Key Ctrl+Enter AcceptLine
