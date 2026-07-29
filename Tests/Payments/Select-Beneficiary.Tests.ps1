<#
.SYNOPSIS
	Tests the features of the `Select-Beneficiary` cmdlet.
#>
Describe "Select-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the beneficiaries of the beneficiary with the specified identifier" {
		$list = Select-AgicapBeneficiary $client $entityId
		Should-BeGreaterThan 1 $list.Count

		$beneficiary = $list.Where{ $_.Name -like "Agicap*" }
		Should-NotBeNull $beneficiary.PostalAddress
		Should-BeString Lyon $beneficiary.PostalAddress.City
		Should-BeString FR $beneficiary.PostalAddress.Country -CaseSensitive
	}
}
