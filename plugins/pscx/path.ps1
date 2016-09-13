# Additional utilities that operate on $ENV:PATH

<#
.SYNOPSIS
  Removes a `path` from environment variables.
#>
function Remove-EnvPathVariable($Path) {
  Set-PathVariable ((Get-PathVariable) -ne $Path)
}

<#
.SYNOPSIS
  Moves a `path` to front or end of environment variables.
#>
function Move-EnvPathVariable($Path, [switch]$prepend=$false) {
  Remove-EnvPathVariable $Path
  Add-PathVariable -Prepend:$prepend $Path
}

<#
.SYNOPSIS
  Removes any `path` environment variable duplicates.
#>
function Remove-EnvPathDuplicates {
  Set-PathVariable (Get-PathVariable | select -Unique)
}
