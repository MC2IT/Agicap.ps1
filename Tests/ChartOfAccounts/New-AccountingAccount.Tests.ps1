<#
.SYNOPSIS
	Tests the features of the `New-AccountingAccount` cmdlet.
#>
Describe "New-AccountingAccount" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new accounting account" {
		$accountingAccount = New-AgicapAccountingAccount 99999999 "MC2IT Development Department"
		Should-BeString "MC2IT Development Department" $accountingAccount.AccountingAccountName -CaseSensitive
		Should-BeString "99999999" $accountingAccount.AccountingAccountNumber
		Should-BeNull $accountingAccount.AccountingAccountType
		Should-BeNull $accountingAccount.ExternalId
		Should-BeNull $accountingAccount.TaxKey
		Should-BeNull $accountingAccount.VatRate

		$accountingAccount.AccountingAccountType = "Vat"
		$accountingAccount.VatRate = 0
		Should-Be ([Mc2it.Agicap.ChartOfAccounts.AccountingAccountType]::Vat) $accountingAccount.AccountingAccountType
		Should-Be 0 $accountingAccount.VatRate
	}
}
