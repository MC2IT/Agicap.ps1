<#
.SYNOPSIS
	Tests the features of the `New-PostalAddress` cmdlet.
#>
Describe "New-PostalAddress" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new postal address" {
		$postalAddress = New-AgicapPostalAddress -City " " -Country " " -StreetName " "
		$postalAddress.IsEmpty | Should-BeTrue
		$postalAddress.Number | Should-BeNull
		$postalAddress.ZipCode | Should-BeNull

		$postalAddress = New-AgicapPostalAddress -City "Paris" -Country "FR" -StreetName "Rue de la Paix" -ZipCode 75000
		$postalAddress.IsEmpty | Should-BeFalse
		$postalAddress.City | Should-BeString "Paris" -CaseSensitive
		$postalAddress.StreetName | Should-BeString "Rue de la Paix" -CaseSensitive
		$postalAddress.ZipCode | Should-BeString "75000"
	}
}
