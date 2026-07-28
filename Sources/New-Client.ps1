using namespace Mc2it.Agicap
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Management.Automation

<#
.SYNOPSIS
	The module version.
#>
[semver] $Script:Version = & {
	$path = "$PSScriptRoot/../Mc2it.Agicap.psd1"
	(Import-PowerShellDataFile ((Test-Path $path) ? $path : "$PSScriptRoot/../Agicap.psd1")).ModuleVersion
}

<#
.SYNOPSIS
	Creates a new Agicap client.
.INPUTS
	The client identifier and secret.
.OUTPUTS
	The newly created client.
#>
function New-Client {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Client])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The client identifier and secret.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline)]
		[Credential()]
		[pscredential] $Credential,

		# The user agent string to use when making requests.
		[ValidateNotNullOrWhiteSpace()]
		[string] $UserAgent = "PowerShell/$($PSVersionTable.PSVersion) | Mc2it.Agicap/$Script:Version",

		# The base URL of the remote API endpoint.
		[ValidateNotNull()]
		[uri] $Uri = "https://api.agicap.com/public/"
	)

	process {
		$client = [Client]::new($Credential, $Uri)
		$client.UserAgent = $UserAgent
		$client
	}
}
