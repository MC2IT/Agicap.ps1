using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Tests the features of the `New-AccountingAccount` cmdlet.
#>
Describe "New-AccountingAccount" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new accounting account" {
		$accountingAccount = New-AgicapAccountingAccount 99999999 "MC2IT Development Department"
		$accountingAccount.AccountingAccountName  | Should-BeString "MC2IT Development Department" -CaseSensitive
		$accountingAccount.AccountingAccountNumber | Should-BeString "99999999"
		$accountingAccount.AccountingAccountType | Should-BeNull
		$accountingAccount.ExternalId | Should-BeNull
		$accountingAccount.TaxKey | Should-BeNull
		$accountingAccount.VatRate | Should-BeNull

		$accountingAccount.AccountingAccountType = "Vat"
		$accountingAccount.VatRate = 0
		$accountingAccount.AccountingAccountType | Should-Be ([Mc2it.Agicap.ChartOfAccounts.AccountingAccountType]::Vat)
		$accountingAccount.VatRate | Should-Be 0
	}
}

<#
.SYNOPSIS
	Tests the features of `Submit-AccountingAccount` and `Remove-AccountingAccount` cmdlets.
#>
Describe "Submit-AccountingAccount" -Skip:($Env:CI -eq "true") {
	BeforeAll {
		. "$PSScriptRoot/../BeforeAll.ps1"
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "accountingAccount")]
		$accountingAccount = New-AgicapAccountingAccount 99999999 "MC2IT Development Department $(New-Guid)" -AccountingAccountType Other
	}

	It "should create or update the specified accounting account" {
		$importResponse = $accountingAccount | Submit-AgicapAccountingAccount $client $entityId -ErrorAction Stop
		while ($importResponse.ImportStatus -eq "Started") {
			Start-Sleep 2.5
			$importResponse = $accountingAccount | Submit-AgicapAccountingAccount $client $entityId -ImportId $importResponse.ImportId -ErrorAction Stop
		}

		$importResponse.ImportStatus | Should-Be ([Mc2it.Agicap.ChartOfAccounts.ImportStatus]::Done)
		$importResponse.ImportSummary.NotImportedCount | Should-Be 0
	}

	It "should delete the specified accounting account" {
		$accountingAccount | Remove-AgicapAccountingAccount $client $entityId -ErrorAction Stop
	}
}
