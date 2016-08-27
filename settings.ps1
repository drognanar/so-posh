# TODO(drognanar): Can we defer loading the following modules?
# By default load modules.
$script:SoPoshAutoloadModules = $global:SoPoshAutoloadModules
if ($null -eq $script:SoPoshAutoloadModules) {
  $script:SoPoshAutoloadModules = @(
    "PSReadline",
    "pscx",
    "posh-git",
    "Jump.Location")
}

# By default load all plugins.
$script:SoPoshPlugins = $global:SoPoshPlugins
if ($null -eq $script:SoPoshPlugins) {
  $script:SoPoshPlugins = @(
    'git/github',
    'git/gitignore',
    'pscx/path',
    'readline',
    'readline/bell',
    'readline/navigation',
    'readline/shebang',
    'themes',
    'utils/commands'
    'utils/execute_in_dir',
    'utils/modules',
    'utils/notifications',
    'utils/port',
    'utils/profile',
    'visualstudio',
    'vscode')
}

# Specifies the default theme to be used by powershell.
$script:SoPoshActiveTheme = $global:SoPoshActiveTheme
if ($null -eq $script:SoPoshActiveTheme) {
  $script:SoPoshActiveTheme = 'default'
}

# Automatically try to import variables from the latest visual studio.
$script:SoPoshVisualStudioVersion = $global:SoPoshVisualStudioVersion
if ($null -eq $script:SoPoshVisualStudioVersion) {
  $script:SoPoshVisualStudioVersion = "140"
}

# If greater than 0 then prompt will notify of any commands that executed for more seconds than the timeout.
$script:SoPoshLastCommandNotificationTimeout = $global:SoPoshLastCommandNotificationTimeout
if ($null -eq $script:SoPoshLastCommandNotificationTimeout) {
  $script:SoPoshLastCommandNotificationTimeout = 0
}

# Do not make a notification if one of the following commands executes for a long time.
$script:SoPoshInteractiveCommands = $global:SoPoshInteractiveCommands
if ($null -eq $script:SoPoshInteractiveCommands) {
  $script:SoPoshInteractiveCommands = @(
    'cmd',
    'powershell',
    'python',
    'ruby')
}
