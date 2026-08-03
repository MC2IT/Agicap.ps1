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

		Should-BeString "FR7630006000011234567890189" $synchronizedBeneficiary.AccountNumber -CaseSensitive
		Should-BeString "BNPAFRPPXXX" $synchronizedBeneficiary.BankIdentifier -CaseSensitive
		Should-BeString "My Bank" $synchronizedBeneficiary.BankName -CaseSensitive
		Should-BeNull $synchronizedBeneficiary.CompanyLegalId
		Should-BeString "MC2IT-DEVELOPMENT" $synchronizedBeneficiary.ErpId -CaseSensitive
		Should-BeString "My Company" $synchronizedBeneficiary.Name -CaseSensitive
		Should-BeString "FR" $synchronizedBeneficiary.PostalAddress.Country -CaseSensitive
	}
}
