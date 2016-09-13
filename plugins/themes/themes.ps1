$script:SoPoshTemplateManager = New-Object PSObject -Property @{
  themes = @{}
  activeTheme = 'default'
}

function global:prompt {
  $ret = . $script:SoPoshTemplateManager.themes[$script:SoPoshTemplateManager.activeTheme]
  return $ret
}

<#
.SYNOPSIS
  Returns whether a command should be treated as long running and should generate a notification.
#>
function Test-LongRunningCommand($CommandExecutionInfo) {
  if ($null -eq $CommandExecutionInfo) {
    return $false
  }

  $timeTaken = $lastExecutingCommand.ExecutionTime
  if ($timeTaken.TotalSeconds -lt $script:SoPoshLastCommandNotificationTimeout) {
    return $false
  }

  $command = $lastExecutingCommand.HistoryInfo
  foreach ($interactiveCommand in $script:SoPoshInteractiveCommands) {
    if ($interactiveCommand -match $command) {
      return $false
    }
  }

  return $true
}

<#
.SYNOPSIS
  Add a new user theme.
#>
function Register-Theme($TemplateName, $Script) {
  $script:SoPoshTemplateManager.themes[$TemplateName] = $Script
}

<#
.SYNOPSIS
  Sets the theme which is used to generate the prompt.
#>
function Set-ActiveTheme($TemplateName) {
  $script:SoPoshTemplateManager.activeTheme = $TemplateName
}

<#
.SYNOPSIS
  Creates a notification if the last command has been executing for a long time.
#>
function New-LastCommandNotification {
  if ($script:SoPoshPlugins -notcontains 'utils/notifications' -or $script:SoPoshLastCommandNotificationTimeout -eq 0) {
    return
  }

  $executionTimes = Get-ExecutionTime
  if ($null -ne $executionTimes) {
    $lastExecutingCommand = $executionTimes[-1]
  }

  if (Test-LongRunningCommand $lastExecutingCommand) {
    New-SuccessNotification $lastExecutingCommand.HistoryInfo
  }
}

ls .\themes\*.ps1 | ForEach-Object { . $_ }

Set-ActiveTheme $script:SoPoshActiveTheme
