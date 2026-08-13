<#
.SYNOPSIS
	Tests the features of the `Deny-AccountingPurchase` cmdlet.
#>
Describe "Deny-AccountingPurchase" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should notify Agicap that the specified purchase journal entries were not correctly imported" {
		Set-ItResult -Skipped -Because "This test requires an Agicap development environment."
	}
}
