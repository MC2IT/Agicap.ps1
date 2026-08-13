<#
.SYNOPSIS
	Tests the features of the `New-BankJournalExportCounts` cmdlet.
#>
Describe "New-BankJournalExportCounts" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return new bank journal export counts" {
		$exportCounts = New-AgicapBankJournalExportCounts -CurrentBankJournalEntriesCountInYear 666 -CurrentBankJournalsCountInYear 123
		Should-Be 666 $exportCounts.CurrentBankJournalEntriesCountInYear
		Should-Be 123 $exportCounts.CurrentBankJournalsCountInYear
	}
}
