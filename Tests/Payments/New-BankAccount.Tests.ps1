<#
.SYNOPSIS
	Tests the features of the `New-BankAccount` cmdlet.
#>
Describe "New-BankAccount" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new bank account" {
		$bankAccount = New-AgicapBankAccount
		Should-BeTrue $bankAccount.IsEmpty
		Should-BeNull $bankAccount.BankName
		Should-BeNull $bankAccount.Identifier

		$bankAccount = New-AgicapBankAccount -BankName "My Bank" -Identifier "FR7630006000011234567890189"
		Should-BeFalse $bankAccount.IsEmpty
		Should-BeString "My Bank" $bankAccount.BankName -CaseSensitive
		Should-BeString "FR7630006000011234567890189" $bankAccount.Identifier -CaseSensitive
	}
}
