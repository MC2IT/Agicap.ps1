using namespace Mc2it.Agicap.Authentication
using namespace System.Management.Automation

<#
.SYNOPSIS
	Connects to Agicap API with an authenticated account.
.OUTPUTS
	The generated authentication token.
#>
function Connect-Api {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Authentication.Token])]
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

	[Token] (Invoke-RestMethod "$ApiUrl/auth/v1/token" -Method Post -Body @{
		client_id = $Credential.UserName
		client_secret = $Credential.GetNetworkCredential().Password
		grant_type = "client_credentials"
		scope = $Scope -join " "
	})
}
