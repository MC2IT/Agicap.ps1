using namespace Microsoft.PowerShell.Commands
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Request-AccessToken` cmdlet.
#>
Describe "Request-AccessToken" {
	It "should return a new access token" -Skip:($Env:CI -eq "true") {
		$credential = [pscredential]::new($Env:AGICAP_CLIENT_ID, (ConvertTo-SecureString $Env:AGICAP_CLIENT_SECRET -AsPlainText))
		$scopes = "agicap:public-api", "public-api:import_payment_files", "public-api:manage-payment-beneficiaries"

		$accessToken = Request-AgicapAccessToken $credential $scopes
		Should-BeFalse $accessToken.HasExpired
		Should-BeCollection $scopes $accessToken.Scopes
		Should-Be ([WebAuthenticationType]::Bearer) $accessToken.Type
		Should-MatchString "^[A-Z\d]{64,}" (ConvertFrom-SecureString $accessToken.Value -AsPlainText) -CaseSensitive
	}

	It "should throw an exception when the credentials are invalid" {
		$credential = [pscredential]::new("FooBar", (ConvertTo-SecureString "BazQux" -AsPlainText))
		Should-Throw -ScriptBlock { Request-AgicapAccessToken $credential -ErrorAction Stop }
	}
}
