<#
.SYNOPSIS
  Creates a new branch with contents of a PR.

.EXAMPLE
  > Get-PR -id 111 -branchname prhello

  Checks out the contents https://github.com/user/project/pulls/111 into branch prhello
#>
function Get-PR($id, $branchname) {
  git fetch dotnet pull/$id/head:$branchname @args
}

<#
.SYNOPSIS
  Updates a new branch with contents of a PR.

.EXAMPLE
  > Update-PR -id 111 -branchname prhello

  Checks out the contents https://github.com/user/project/pulls/111 into branch prhello
#>
function Update-PR($id, $branchname) {
  git pull dotnet pull/$id/head:$branchname @args
}
