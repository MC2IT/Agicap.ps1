using namespace System.Diagnostics.CodeAnalysis
using module ../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `ProblemDetails` class.
#>
Describe "ProblemDetails" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../Resources/ProblemDetails.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create an access token from the specified JSON payload" {
			$problemDetails = [Mc2it.Agicap.ProblemDetails] $json

			Should-BeString "The request body is invalid and not meeting business rules." $problemDetails.Detail -CaseSensitive
			Should-Be 2 $problemDetails.Extensions.Count
			Should-Be 422 $problemDetails.Status
			Should-BeString "Business Rule Violation" $problemDetails.Title -CaseSensitive
			Should-Be ([uri]::new("https://problems-registry.smartbear.com/business-rule-violation")) $problemDetails.Type

			Should-BeString "422-01" $problemDetails.Extensions.code -CaseSensitive
			Should-HaveType ([psobject]) $problemDetails.Extensions.errors
			Should-BeString "maximum quantity is 999" $problemDetails.Extensions.errors.quantity -CaseSensitive
		}
	}
}
