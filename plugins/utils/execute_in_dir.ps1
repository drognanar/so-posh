<#
.SYNOPSIS
  Execute a particular scriptblock inside of a directory.

.DESCRIPTION
  Executes a `scriptblock` with `dir` as working directory.
  Unlike `cd` and `pushd` `Invoke-InDir` ensures to go back
  to the previous directory once the script ends.
#>
function Invoke-InDir($dir, $scriptblock) {
  if ((pwd).Path -eq (Resolve-Path $dir).Path) {
    . $scriptblock @args
    return
  }
  pushd $dir
  try {
    Write-Host Executing "in" dir $dir
    . $scriptblock @args
  } finally {
    popd
  }
}
