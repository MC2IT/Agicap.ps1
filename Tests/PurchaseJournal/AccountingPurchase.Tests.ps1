<#
.SYNOPSIS
	Tests the features of the `Deny-AccountingPurchase` cmdlet.
#>
Describe "Deny-AccountingPurchase" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should notify Agicap that the specified purchase journal entries were not correctly imported" {
		Set-ItResult -Skipped -Because "This test requires an Agicap development environment."
	}
}

<#
.SYNOPSIS
	Tests the features of the `Select-AccountingPurchase` cmdlet.
#>
Describe "Select-AccountingPurchase" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the entries of the purchase journal" {
		$lastSynchronizationDate = [datetime] "2026-01-01T00:00:00Z"
		$purchaseJournalEntries = (Select-AgicapAccountingPurchase $client $entityId $lastSynchronizationDate -PageSize 2).Items
		$purchaseJournalEntries | Should-BeCollection -Count 2

		foreach ($purchaseJournalEntry in $purchaseJournalEntries) {
			$purchaseJournalEntry.AgicapUniqueId | Should-NotBe ([guid]::Empty)
			$purchaseJournalEntry.AccountingLines.Count | Should-BeGreaterThanOrEqual 1
			($purchaseJournalEntry.AccountingLines | Measure-Object -Sum { $_.Credit - $_.Debit }).Sum | Should-Be 0
			($purchaseJournalEntry.AccountingLines | Where-Object { $_.Currency -eq "EUR" }).Count | Should-Be $purchaseJournalEntry.AccountingLines.Count
		}
	}
}
