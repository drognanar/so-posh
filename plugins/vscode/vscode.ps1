<#
.SYNOPSIS
  Starts a VsCode application. By default reuses a window.
#>
function Invoke-VsCode([switch]$NewWindow) {
  if ($NewWindow) {
    code.cmd -r @args
  } else {
    code.cmd @args
  }
}
