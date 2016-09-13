<#
.SYNOPSIS
  Create a PowerShell notification.

.DESCRIPTION
  This script provides a function to create a system notification.
  Can be used to notify about scripts status.
  Taken from https://technet.microsoft.com/en-us/library/ff730952.aspx
#>
function New-Notification($message, $title="", $icon="info") {
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
  [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
  $objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
  $objNotifyIcon.Icon = [System.Drawing.SystemIcons]::Information
  $objNotifyIcon.Visible = $True
  $objNotifyIcon.ShowBalloonTip(60000, $title, $message, $icon)
  $objNotifyIcon.Visible = $False
}

<#
.SYNOPSIS
  Creates a notification whether the last command has executed successfully.

.DESCRIPTION
  Runs `code` and prints a success notification after running a script.
  Needs to be called after code is run.
#>
function New-SuccessNotification($successMessage, $failMessage) {
  if ($failMessage -eq $null) {
    $failMessage = $successMessage
  }

  if ($?) {
    New-Notification $successMessage "" "info"
  } else {
    New-Notification $failMessage "" "error"
  }
}
