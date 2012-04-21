$argsHash = @{}
$splittedArgs = $Args[0].split(";")

for($x=0; $x -lt $splittedArgs.Length; $x++) {
   
   $curArgSplit = $splittedArgs[$x].split("=")
   $argsHash.add($curArgSplit[0], $curArgSplit[1]);   
}

if ($argsHash.ConfigurationName -eq "Debug")
{
	$argsHash.TargetPath += ".config";
	[System.IO.File]::Copy($global:DefaultConfig, $argsHash.TargetPath, $true);
	[System.IO.File]::SetAttributes($argsHash.TargetPath, [System.IO.FileAttributes]::Normal);
}
