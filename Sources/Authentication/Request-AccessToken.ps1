using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Authentication

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
		[ValidateNotNullOrEmpty()]
		[string[]] $Scope = @([Scopes]::PublicApi)
	)

	$Client.Authenticate($Scope)
}
