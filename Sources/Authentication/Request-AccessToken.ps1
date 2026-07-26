using namespace Mc2it.Agicap.Authentication
using namespace System.Management.Automation

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
		# The client identifier and secret.
		[Parameter(Mandatory, Position = 1)]
		[Credential()]
		[pscredential] $Credential,

		# The delegated permissions to consent to.
		[Parameter(Position = 2)]
		[ValidateNotNullOrEmpty()]
		[string[]] $Scope = @("agicap:public-api")
	)

	return [AccessToken] (Invoke-RestMethod "$(Get-ApiUrl)/auth/v1/token" -Method Post -Body @{
		client_id = $Credential.UserName
		client_secret = $Credential.GetNetworkCredential().Password
		grant_type = "client_credentials"
		scope = $Scope -join " "
	})
}
