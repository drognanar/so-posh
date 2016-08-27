function Get-PR($id, $branchname) {
    git fetch dotnet pull/$id/head:$branchname @args
}

function Update-PR($id, $branchname) {
    git pull dotnet pull/$id/head:$branchname @args
}