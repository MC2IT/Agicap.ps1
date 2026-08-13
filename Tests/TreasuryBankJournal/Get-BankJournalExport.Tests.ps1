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
