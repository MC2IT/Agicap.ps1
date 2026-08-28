<#
.SYNOPSIS
	Tests the features of the `Get-BankJournalExport` cmdlet.
#>
Describe "Get-BankJournalExport" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the bank journal export with the given identifier" {
		$bankJournalExport = Get-AgicapBankJournalExport $client $entityId "575d62e4-e965-49fd-9a2d-b53bb1ad5434"
		Should-BeString "MC2IT" $bankJournalExport.EntityName -CaseSensitive
		Should-BeCollection $bankJournalExport.Entries -Count 5
		Should-Be 2026 $bankJournalExport.Year

		$bankJournalEntry = $bankJournalExport.Entries[-1]
		Should-BeString "EUR" $bankJournalEntry.AccountingCurrency -CaseSensitive
		Should-BeNull $bankJournalEntry.Causale
		Should-BeCollection $bankJournalEntry.Counterparts -Count 1
		Should-BeLikeString "MC2IT*" $bankJournalEntry.Counterparts[0].Name -CaseSensitive
		Should-BeNull $bankJournalEntry.EntryMemo
		Should-BeLikeString "MC2IT*" $bankJournalEntry.Name -CaseSensitive
		Should-BeString "EUR" $bankJournalEntry.OriginalCurrency -CaseSensitive
	}
}

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

<#
.SYNOPSIS
	Tests the features of the `Select-BankJournalExport` cmdlet.
#>
Describe "Select-BankJournalExport" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a paginated list of bank journal exports" {
		$list = Select-AgicapBankJournalExport $client $entityId -Before "2026-07-21T23:59:59Z"
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
