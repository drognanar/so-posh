# Install script.
# Add any dependant modules that should be installed.
if (-not [System.IO.Directory]::Exists($PROOT\Modules\so-posh)) {
    git clone https://github.com/drognanar/so-posh $PROOT\Modules\so-posh
    & $PROOT\Modules\so-posh\install.ps1
}