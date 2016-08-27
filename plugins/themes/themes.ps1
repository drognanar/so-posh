$script:PoshTemplateManager = New-Object PSObject -Property @{
  themes = @{}
  activeTheme = 'default'
}

function global:prompt {
  . $script:PoshTemplateManager.themes[$script:PoshTemplateManager.activeTheme]
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
  if ($script:PoshPlugins -notcontains 'utils/notifications' -or $script:LastCommandNotificationTimeout -eq 0) {
    return
  }

  $executionTime = (Get-ExecutionTime)[-1]
  if ($executionTime.ExecutionTime.TotalSeconds -gt $script:LastCommandNotificationTimeout) {
    New-SuccessNotification $executionTime.HistoryInfo
  }
}

ls .\themes\*.ps1 | ForEach-Object { . $_ }

Set-ActiveTheme $script:PoshActiveTheme
