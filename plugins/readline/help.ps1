# source: https://github.com/lzybkr/PSReadLine/blob/master/PSReadLine/SamplePSReadlineProfile.ps1
# F1 for help on the command line - naturally
Set-PSReadlineKeyHandler -Key F1 `
                         -BriefDescription CommandHelp `
                         -LongDescription "Open the help window for the current command" `
                         -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  $commandAst = $ast.FindAll( {
    $node = $args[0]
    $node -is [System.Management.Automation.Language.CommandAst] -and
      $node.Extent.StartOffset -le $cursor -and
      $node.Extent.EndOffset -ge $cursor
    }, $true) | Select-Object -Last 1

  if ($commandAst -ne $null) {
    $commandName = $commandAst.GetCommandName()
    if ($commandName -ne $null) {
      $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
      if ($command -is [System.Management.Automation.AliasInfo]) {
        $commandName = $command.ResolvedCommandName
      }

      if ($commandName -ne $null) {
        Invoke-Shortcut "(Get-Help $commandName).Syntax | more"
      }
    }
  }
}
