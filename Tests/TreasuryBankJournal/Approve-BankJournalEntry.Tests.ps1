<#
.SYNOPSIS
	Tests the features of the `Approve-BankJournalEntry` cmdlet.
#>
Describe "Approve-BankJournalEntry" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should notify Agicap that the specified bank journal entries were successfully imported" {
		Set-ItResult -Skipped -Because "This test requires an Agicap development environment."
	}
}
