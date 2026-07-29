using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Authentication
using namespace System.Net.Http

<#
.SYNOPSIS
	Requests a new access token.
.OUTPUTS
	The generated access token.
#>
function Request-AccessToken {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Authentication.AccessToken])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The delegated permissions to consent to.
		[Parameter(Position = 2)]
		[ValidateNotNull()]
		[string[]] $Scope = @()
	)

	try { $Client.Authenticate($Scope) }
	catch [HttpRequestException] { Write-Error $_ }
}
