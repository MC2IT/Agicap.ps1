using namespace Microsoft.PowerShell.Commands
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `AccessToken` class.
#>
Describe "AccessToken" {
	Context "FromJson" {
		It "should create an access token from the specified JSON payload" {
			$token = [Mc2it.Agicap.Authentication.AccessToken] (ConvertFrom-Json '{
				"access_token": "a1704b4b-7662-432e-a68e-77f414fb836c",
				"expires_in": 3600,
				"scope": "agicap:public-api public-api:import_payment_files public-api:manage-payment-beneficiaries",
				"token_type": "OAuth"
			}')

			Should-BeFalse $token.HasExpired
			Should-BeCollection "agicap:public-api", "public-api:import_payment_files", "public-api:manage-payment-beneficiaries" $token.Scopes
			Should-Be ([WebAuthenticationType]::OAuth) $token.Type
			Should-BeString "a1704b4b-7662-432e-a68e-77f414fb836c" (ConvertFrom-SecureString $token.Value -AsPlainText) -CaseSensitive
		}
	}
}
