<#
.SYNOPSIS
  Loads visual studio environment variables.

.DESCRIPTION
  Loads visual studio environment variables.
  This method does not do anything if called for the second time.
#>
function Enable-DeveloperCommandPrompt([Switch]$Force=$false) {
  if ($force -or ($null -eq $env:DevEnvDir)) {
    Import-VisualStudioVars $script:SoPoshVisualStudioVersion
  }
}

# Create a shim for visual studio commands to load the environment only if one
# of the commands is called.
# This is done to avoid loading visual studio vars on every profile startup.

function Invoke-Devenv {
  Enable-DeveloperCommandPrompt
  devenv.exe @args
}

function Invoke-ILdasm {
  Enable-DeveloperCommandPrompt
  ildasm.exe @args
}

function Invoke-MSBuild {
  Enable-DeveloperCommandPrompt
  msbuild.exe @args
}

Set-Alias devenv  Invoke-Devenv
Set-Alias ildasm  Invoke-ILDasm
Set-Alias msbuild Invoke-MSBuild
