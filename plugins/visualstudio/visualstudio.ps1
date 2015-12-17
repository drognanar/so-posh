function Enable-DeveloperCommandPrompt([Switch]$Force=$false) {
    if ($force -or ($null -eq $env:DevEnvDir)) {
        Import-VisualStudioVars $script:VisualStudioVersion
    }
}

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
