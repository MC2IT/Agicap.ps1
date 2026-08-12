<#
.SYNOPSIS
	Tests the features of the `Deny-AccountingPurchase` cmdlet.
#>
Describe "Deny-AccountingPurchase" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should report errors on exported purchase journal entries" -Skip {
		# This test requires an Agicap development environment.
	}
}
