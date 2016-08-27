# TODO(drognanar): Can we defer loading the following modules?
# By default load modules.
$script:PoshAutoloadModules = $global:PoshAutoloadModules
if ($null -eq $script:PoshAutoloadModules) {
  $script:PoshAutoloadModules = @(
    "PSReadline",
    "pscx",
    "posh-git",
    "Jump.Location")
}

# By default load all plugins.
$script:PoshPlugins = $global:PoshPlugins
if ($null -eq $script:PoshPlugins) {
  $script:PoshPlugins = @(
    'git/github',
    'git/gitignore',
    'pscx/path',
    'readline',
    'readline/bell',
    'readline/navigation',
    'readline/shebang',
    'themes',
    'utils/execute_in_dir',
    'utils/modules',
    'utils/notifications',
    'utils/port',
    'utils/profile',
    'visualstudio')
}

# Specifies the default theme to be used by powershell.
$script:PoshActiveTheme = $global:PoshActiveTheme
if ($null -eq $script:PoshActiveTheme) {
  $script:PoshActiveTheme = 'default'
}

# Automatically try to import variables from the latest visual studio.
$script:VisualStudioVersion = $global:VisualStudioVersion
if ($null -eq $script:VisualStudioVersion) {
  $script:VisualStudioVersion = "140"
}

# If greater than 0 then prompt will notify of any commands that executed for more seconds than the timeout.
$script:LastCommandNotificationTimeout = $global:LastCommandNotificationTimeout
if ($null -eq $script:LastCommandNotificationTimeout) {
  $script:LastCommandNotificationTimeout = 0
}
