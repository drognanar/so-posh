<#
.SYNOPSIS
  Creates new .gitignore file.

.NOTES
  Based on gitignore.io script
  For PowerShell v3
#>
Function New-Gitignore {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$List
  )
  $params = $List -join ","
  Invoke-WebRequest -Uri "https://www.gitignore.io/api/$params" | select -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

Set-Alias gig New-Gitignore
