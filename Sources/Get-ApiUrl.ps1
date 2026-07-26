<#
.SYNOPSIS
	Gets the base URL of the Agicap public API.
.OUTPUTS
	[string] The base URL of the Agicap public API.
.OUTPUTS
	[uri] The base URL of the Agicap public API.
#>
function Get-ApiUrl {
	[CmdletBinding()]
	[OutputType([string])]
	param (
		# Value indicating whether to return a `[uri]` instance instead of a string.
		[switch] $AsUri
	)

	$url = "https://api.agicap.com/public"
	$AsUri ? [uri]::new("$url/") : $url
}
