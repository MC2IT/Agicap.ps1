<#
.SYNOPSIS
	Tests the features of the `New-SynchronizedBeneficiary` cmdlet.
#>
Describe "New-SynchronizedBeneficiary" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new synchronized beneficiary" {
		$bankAccount = New-AgicapBankAccount "My Bank" -Bic "BNPAFRPPXXX" -Identifier "FR7630006000011234567890189"
		$postalAddress = New-AgicapPostalAddress -City Paris -Country FR -StreetName "Rue de la Paix" -ZipCode 75000
		$synchronizedBeneficiary = New-AgicapSynchronizedBeneficiary "MC2IT-DEVELOPMENT" (New-AgicapBeneficiary "My Company" -BankAccount $bankAccount -PostalAddress $postalAddress)

		$synchronizedBeneficiary.AccountNumber | Should-BeString "FR7630006000011234567890189" -CaseSensitive
		$synchronizedBeneficiary.BankIdentifier | Should-BeString "BNPAFRPPXXX" -CaseSensitive
		$synchronizedBeneficiary.BankName | Should-BeString "My Bank" -CaseSensitive
		$synchronizedBeneficiary.CompanyLegalId | Should-BeNull
		$synchronizedBeneficiary.ErpId | Should-BeString "MC2IT-DEVELOPMENT" -CaseSensitive
		$synchronizedBeneficiary.Name | Should-BeString "My Company" -CaseSensitive
		$synchronizedBeneficiary.PostalAddress.Country | Should-BeString "FR" -CaseSensitive
		$synchronizedBeneficiary.SupplierErpIds | Should-BeNull
	}
}
