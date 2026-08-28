<#
.SYNOPSIS
	Tests the features of the `New-PostalAddress` cmdlet.
#>
Describe "New-PostalAddress" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new postal address" {
		$postalAddress = New-AgicapPostalAddress -City " " -Country " " -StreetName " "
		Should-BeTrue $postalAddress.IsEmpty
		Should-BeNull $postalAddress.Number
		Should-BeNull $postalAddress.ZipCode

		$postalAddress = New-AgicapPostalAddress -City "Paris" -Country "FR" -StreetName "Rue de la Paix" -ZipCode 75000
		Should-BeFalse $postalAddress.IsEmpty
		Should-BeString "Paris" $postalAddress.City -CaseSensitive
		Should-BeString "Rue de la Paix" $postalAddress.StreetName -CaseSensitive
		Should-BeString 75000 $postalAddress.ZipCode
	}
}
