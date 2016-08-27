$script:PoshTemplateManager = New-Object PSObject -Property @{
  themes = @{}
  activeTheme = 'default'
}

function global:prompt {
  . $script:PoshTemplateManager.themes[$script:PoshTemplateManager.activeTheme]
}

function Test-LongRunningCommand($commandExecutionInfo) {
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
function Register-Theme($templateName, $script) {
  $script:PoshTemplateManager.themes[$templateName] = $script
}

<#
.SYNOPSIS
  Sets the theme which is used to generate the prompt.
#>
function Set-ActiveTheme($templateName) {
  $script:PoshTemplateManager.activeTheme = $templateName
}

<#
.SYNOPSIS
  Creates a notification if the last command has been executing for a long time.
#>
function New-LastCommandNotification {
  if ($script:SoPoshPlugins -notcontains 'utils/notifications' -or $script:SoPoshLastCommandNotificationTimeout -eq 0) {
    return
  }

  $lastExecutingCommand = (Get-ExecutionTime)[-1]
  if (Test-LongRunningCommand $lastExecutingCommand) {
    New-SuccessNotification $lastExecutingCommand.HistoryInfo
  }
}

ls .\themes\*.ps1 | ForEach-Object { . $_ }

Set-ActiveTheme $script:SoPoshActiveTheme
