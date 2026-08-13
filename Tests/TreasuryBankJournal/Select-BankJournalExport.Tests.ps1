<#
.SYNOPSIS
	Tests the features of Select-BankJournalExport.
#>
Describe "Select-BankJournalExport" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a paginated list of bank journal exports" {
		$list = Select-AgicapBankJournalExport $client $entityId -Before ([datetime] "2026-07-21T23:59:59Z")
		Should-BeCollection $list.Items -Count 3

		$exportSummary = $list.Items[0]
		Should-Be ([datetime] "2026-07-21T13:52:44.861Z").ToUniversalTime() $exportSummary.ExportDateUtc
		Should-NotBe (New-Guid -Empty) $exportSummary.ExportId
		Should-BeGreaterThan 1 $exportSummary.ExportIndexInYear
		Should-Be 2026 $exportSummary.ExportYear
		Should-BeGreaterThan 1 $exportSummary.IndexInYearOfFirstEntryInBankJournal
		Should-BeGreaterThan 1 $exportSummary.IndexInYearOfLastEntryInBankJournal
		Should-Be 222 $exportSummary.NumberOfEntries
	}
}
