using namespace Mc2it.Agicap.Authentication
using namespace System.Management.Automation
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
		# The client identifier and secret.
		[Parameter(Mandatory, Position = 1)]
		[Credential()]
		[pscredential] $Credential,

		# The delegated permissions to consent to.
		[Parameter(Position = 2)]
		[ValidateNotNullOrEmpty()]
		[string[]] $Scope = @("agicap:public-api")
	)

	$response = Invoke-RestMethod "$(Get-ApiUrl)/auth/v1/token" -Method Post -SkipHttpErrorCheck -StatusCodeVariable statusCode -Body @{
		client_id = $Credential.UserName
		client_secret = $Credential.GetNetworkCredential().Password
		grant_type = "client_credentials"
		scope = $Scope -join " "
	}

	switch ($statusCode) {
		200 { return [AccessToken] $response }
		400 { Write-Error ([BadRequest] $response).Error -Category AuthenticationError -TargetObject $response; break }
		default { Write-Error ([HttpRequestException]::new("TODO", $null, $statusCode)) -TargetObject $response }
	}
}
