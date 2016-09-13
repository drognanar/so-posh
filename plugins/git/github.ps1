<#
.SYNOPSIS
  Creates a new branch with contents of a PR.

.EXAMPLE
  Get-PR -id 111 -branchname prhello

  Check out the contents https://github.com/user/project/pulls/111 into branch prhello
#>
function Get-PR($id, $branchname, [switch]$update=$false) {
  if ($update) {
    git pull dotnet pull/$id/head:$branchname @args
  } else {
    git fetch dotnet pull/$id/head:$branchname @args
  }
}
