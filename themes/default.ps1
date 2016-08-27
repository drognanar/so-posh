Register-Theme 'default' {
  New-LastCommandNotification

  Write-Host 'PS ' -nonewline
  Write-Host($pwd.ProviderPath) -nonewline
  return "> "
}
