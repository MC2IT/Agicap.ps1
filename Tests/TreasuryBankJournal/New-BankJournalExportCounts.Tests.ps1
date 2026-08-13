<#
.SYNOPSIS
	Tests the features of the `New-BankJournalExportCounts` cmdlet.
#>
Describe "New-BankJournalExportCounts" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new bank journal export request" {
		$exportRequest = New-AgicalExportCounts -CurrentBankJournalEntriesCountInYear 666 -CurrentBankJournalsCountInYear 123
		Should-Be 666 $exportRequest.CurrentBankJournalEntriesCountInYear
		Should-Be 123 $exportRequest.CurrentBankJournalsCountInYear
	}
}
