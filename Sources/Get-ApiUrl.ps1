<#
.SYNOPSIS
	Gets the base URL of the Agicap public API.
.OUTPUTS
	The base URL of the Agicap public API.
#>
function Get-ApiUrl {
	[CmdletBinding()]
	[OutputType([string])]
	param ()

	"https://api.agicap.com"
}
