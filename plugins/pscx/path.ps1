# Additional utilities that operate on $ENV:PATH

# Removes a `path` from environment variables.
function Remove-EnvPathVariable($path) {
  Set-PathVariable ((Get-PathVariable) -ne $path)
}

# Moves a `path` to front or end of environment variables.
function Move-EnvPathVariable($path, [switch]$prepend=$false) {
  Remove-EnvPathVariable $path
  Add-PathVariable -Prepend:$prepend $path
}

# Removes any `path` environment variable duplicates.
function Remove-EnvPathDuplicates {
  Set-PathVariable (Get-PathVariable | select -Unique)
}
