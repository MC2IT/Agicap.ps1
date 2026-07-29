<#
.SYNOPSIS
	Tests the features of the `New-Beneficiary` cmdlet.
#>
Describe "New-Beneficiary" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new beneficiary" {
		$postalAddress = New-AgicapPostalAddress -City " " -Country " " -StreetName " "
		$beneficiary = New-AgicapBeneficiary "My Company" -PostalAddress $postalAddress
		Should-BeString "My Company" $beneficiary.Name -CaseSensitive
		Should-BeNull $beneficiary.BankAccount
		Should-BeNull $beneficiary.Id
		Should-BeNull $beneficiary.PostalAddress
	}
}
