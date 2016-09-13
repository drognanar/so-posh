<#
.SYNOPSIS
  Creates a new branch with contents of a PR.

.EXAMPLE
  Get-PR -id 111 -branchname prhello

  Check out the contents https://github.com/user/project/pulls/111 into branch prhello
#>
function Get-PR($Id, $Branchname, [switch]$Update=$false) {
  if ($Update) {
    git pull dotnet pull/$Id/head:$Branchname @args
  } else {
    git fetch dotnet pull/$Id/head:$Branchname @args
  }
}
