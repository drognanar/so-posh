# Theme extracted from posh-git
Register-Theme 'posh-git' {
  New-LastCommandNotification

  $realLASTEXITCODE = $LASTEXITCODE

  Write-Host($pwd.ProviderPath) -nonewline
  try { Write-VcsStatus } catch { }

  $global:LASTEXITCODE = $realLASTEXITCODE
  return "> "
}
