<#
.SYNOPSIS
	Tests the features of the `New-BankJournalExportRequest` cmdlet.
#>
Describe "New-BankJournalExportRequest" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new bank journal export request" {
		$exportRequest = New-AgicapBankJournalExportRequest -CurrentBankJournalEntriesCountInYear 666 -CurrentBankJournalsCountInYear 123
		Should-Be 666 $exportRequest.CurrentBankJournalEntriesCountInYear
		Should-Be 123 $exportRequest.CurrentBankJournalsCountInYear
	}
}
