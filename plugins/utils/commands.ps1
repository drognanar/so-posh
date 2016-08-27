<#
.SYNOPSIS
  Shows details for selected commands in selected modules.

.DESCRIPTION
  Shows details for selected commands in selected modules.
  If name is missing displays all commands and aliases.
  If name is specified displays command name along with its definition.
  If modules is missing displays commands from all modules.
#>
function Show-CommandDetails($name = $null, $modules=@()) {
  if ($null -eq $name) {
    Get-Command -All -Module $modules | sort name | select name, definition
  } else {
    Get-Command $name | % { "name: $($_.Name)`ncommand: $($_.Definition)" }
  }
}
