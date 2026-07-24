using namespace Microsoft.PowerShell.Commands
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Token` class.
#>
Describe "Token" {
	Context "FromJson" {
		It "TODO" {
			$token = [Mc2it.Agicap.Authentication.Token] (ConvertFrom-Json '{
				"access_token": "a1704b4b-7662-432e-a68e-77f414fb836c",
				"expires_in": 0,
				"scope": "agicap:public-api public-api:import_payment_files public-api:manage-payment-beneficiaries",
				"token_type": "Bearer"
			}')

			Should-BeTrue $token.HasExpired
			Should-BeCollection "agicap:public-api", "public-api:import_payment_files", "public-api:manage-payment-beneficiaries" $token.Scopes
			Should-Be ([WebAuthenticationType]::Bearer) $token.Type
			Should-BeString "a1704b4b-7662-432e-a68e-77f414fb836c" (ConvertFrom-SecureString $token.Value -AsPlainText) -CaseSensitive
		}
	}
}
