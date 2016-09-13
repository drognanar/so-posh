<#
.SYNOPSIS
  Execute a particular scriptblock inside of a directory.

.DESCRIPTION
  Executes a `scriptblock` with `dir` as working directory.
  Unlike `cd` and `pushd` `Invoke-InDir` ensures to go back
  to the previous directory once the script ends.
#>
function Invoke-InDir($Dir, $Scriptblock) {
  if ((pwd).Path -eq (Resolve-Path $Dir).Path) {
    . $Scriptblock @args
    return
  }
  pushd $Dir
  try {
    Write-Host Executing "in" dir $Dir
    . $Scriptblock @args
  } finally {
    popd
  }
}
