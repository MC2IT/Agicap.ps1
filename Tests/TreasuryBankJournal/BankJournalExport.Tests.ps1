<#
.SYNOPSIS
	Tests the features of the `Get-BankJournalExport` cmdlet.
#>
Describe "Get-BankJournalExport" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the bank journal export with the given identifier" {
		$bankJournalExport = Get-AgicapBankJournalExport $client -EntityId $entityId -ExportId "575d62e4-e965-49fd-9a2d-b53bb1ad5434"
		$bankJournalExport.EntityName | Should-BeString "MC2IT" -CaseSensitive
		$bankJournalExport.Entries | Should-BeCollection -Count 5
		$bankJournalExport.Year | Should-Be 2026

		$bankJournalEntry = $bankJournalExport.Entries[-1]
		$bankJournalEntry.AccountingCurrency | Should-BeString "EUR" -CaseSensitive
		$bankJournalEntry.Causale | Should-BeNull
		$bankJournalEntry.Counterparts | Should-BeCollection -Count 1
		$bankJournalEntry.Counterparts[0].Name | Should-BeLikeString "MC2IT*" -CaseSensitive
		$bankJournalEntry.EntryMemo | Should-BeNull
		$bankJournalEntry.Name | Should-BeLikeString "MC2IT*" -CaseSensitive
		$bankJournalEntry.OriginalCurrency | Should-BeString "EUR" -CaseSensitive
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
		$exportCounts.CurrentBankJournalEntriesCountInYear | Should-Be 666
		$exportCounts.CurrentBankJournalsCountInYear | Should-Be 123
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
		$list.Items | Should-BeCollection -Count 3

		$exportSummary = $list.Items[0]
		$exportSummary.ExportDateUtc | Should-Be ([datetime] "2026-07-21T13:52:44.861Z").ToUniversalTime()
		$exportSummary.ExportId | Should-NotBe (New-Guid -Empty)
		$exportSummary.ExportIndexInYear | Should-BeGreaterThan 1
		$exportSummary.ExportYear | Should-Be 2026
		$exportSummary.IndexInYearOfFirstEntryInBankJournal | Should-BeGreaterThan 1
		$exportSummary.IndexInYearOfLastEntryInBankJournal | Should-BeGreaterThan 1
		$exportSummary.NumberOfEntries | Should-Be 222
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
