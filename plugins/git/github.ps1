function Get-GithubPr($id, $branchname) {
    git fetch origin pull/$id/head:$branchname
}
