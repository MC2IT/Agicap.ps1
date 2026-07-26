using namespace Microsoft.PowerShell.Commands
using namespace System.Diagnostics.CodeAnalysis
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `AccessToken` class.
#>
Describe "AccessToken" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../../Resources/Authentication/AccessToken.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create an access token from the specified JSON payload" {
			$accessToken = [Mc2it.Agicap.Authentication.AccessToken] $json
			Should-BeFalse $accessToken.HasExpired
			Should-BeCollection "agicap:public-api", "public-api:import_payment_files", "public-api:manage-payment-beneficiaries" $accessToken.Scopes
			Should-Be ([WebAuthenticationType]::OAuth) $accessToken.Type
			Should-BeString "a1704b4b-7662-432e-a68e-77f414fb836c" (ConvertFrom-SecureString $accessToken.Value -AsPlainText) -CaseSensitive
		}
	}
}
