<#
.SYNOPSIS
	Tests the features of the `New-BankAccount` cmdlet.
#>
Describe "New-BankAccount" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new bank account" {
		$bankAccount = New-AgicapBankAccount
		$bankAccount.IsEmpty | Should-BeTrue
		$bankAccount.BankName | Should-BeNull
		$bankAccount.Identifier | Should-BeNull

		$bankAccount = New-AgicapBankAccount -BankName "My Bank" -Identifier "FR7630006000011234567890189"
		$bankAccount.IsEmpty | Should-BeFalse
		$bankAccount.BankName | Should-BeString "My Bank" -CaseSensitive
		$bankAccount.Identifier | Should-BeString "FR7630006000011234567890189" -CaseSensitive
	}
}
