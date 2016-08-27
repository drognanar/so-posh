Import-Module so-posh

# Load all other ps1 files in this directory.
# Besides `install.ps1` which is used when installing a module.
try {
  pushd $PSScriptRoot
  foreach ($script in (ls *.ps1 -Exclude "install.ps1")) {
    . $script
  }
}
finally {
  popd
}
