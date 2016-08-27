<#
.SYNOPSIS
  Starts a VsCode application. By default reuses a window.
#>
function Invoke-VsCode([switch]$ReuseWindow = $true) {
  if ($ReuseWindow) {
    code.cmd -r @args
  } else {
    code.cmd @args
  }
}
