<#
.SYNOPSIS
  Shows details for selected commands in selected modules.

.DESCRIPTION
  Shows details for selected commands in selected modules.
  If name is missing displays all commands and aliases.
  If name is specified displays command name along with its definition.
  If modules is missing displays commands from all modules.
#>
function Show-CommandDetails($Name = $null, $Modules=@()) {
  if ($null -eq $Name) {
    Get-Command -All -Module $Modules | sort name | select name, definition
  } else {
    Get-Command $Name | % { "name: $($_.Name)`ncommand: $($_.Definition)" }
  }
}
