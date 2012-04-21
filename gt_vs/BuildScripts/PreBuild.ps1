$defaultLocation = $Args[0]
if ($defaultLocation)
{	
	Set-Location -Path  $defaultLocation
	$builScriptsPath = Join-Path -Path $defaultLocation -ChildPath "BuildScripts\"
	$configScript = Join-Path -Path $builScriptsPath  -ChildPath "Config.ps1"
	. $configScript $defaultLocation
} else { throw "Default location param is empty!"}

$copyConfigArgs = $Args[1]
if ($copyConfigArgs)
{
	$copyScript = Join-Path -Path $builScriptsPath -ChildPath "CopyConfig.ps1"	
	. $copyScript $copyConfigArgs
} else { throw "No args provided to copy config files!" }

return 0;