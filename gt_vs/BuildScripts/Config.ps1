$global:MergedCssFileName = "themes_all.css"
$configPath = "GT.Web.Site\Web.config"
$global:DefaultConfig = Join-Path -Path $Args[0] -ChildPath $configPath 
if ([System.IO.File]::Exists($global:DefaultConfig) -ne $true)
{
	throw "Cannot find file $global:DefaultConfig"
}