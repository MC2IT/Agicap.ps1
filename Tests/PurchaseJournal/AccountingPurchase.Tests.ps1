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
		$purchaseJournalEntries = Select-AgicapAccountingPurchase $client -EntityId $entityId -LastSynchronizationDate $lastSynchronizationDate -PageSize 2
		$purchaseJournalEntries.Items | Should-BeCollection -Count 2

		$purchaseJournalEntries.Items | ForEach-Object {
			$_.AgicapUniqueId | Should-NotBe ([guid]::Empty)
			$_.AccountingLines.Count | Should-BeGreaterThanOrEqual 1
			($_.AccountingLines | Measure-Object -Sum { $_.Credit - $_.Debit }).Sum | Should-Be 0
			($_.AccountingLines | Where-Object { $_.Currency -eq "EUR" }).Count | Should-Be $_.AccountingLines.Count
		}
	}
}
