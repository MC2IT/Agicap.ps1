<#
.SYNOPSIS
	Tests the features of the `Deny-BankJournalEntry` cmdlet.
#>
Describe "Deny-BankJournalEntry" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should notify Agicap that the specified bank journal entries were not correctly imported" {
		Set-ItResult -Skipped -Because "This test requires an Agicap development environment."
	}
}
