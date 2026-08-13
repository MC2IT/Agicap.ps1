<#
.SYNOPSIS
	Tests the features of the `Submit-BankJournalExport` cmdlet.
#>
Describe "Submit-BankJournalExport" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should export all bank journal entries ready to be exported" {
		Set-ItResult -Skipped -Because "This test requires an Agicap development environment."
	}
}
