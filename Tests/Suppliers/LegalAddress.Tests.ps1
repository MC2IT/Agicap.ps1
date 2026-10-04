<#
.SYNOPSIS
	Tests the features of the `New-LegalAddress` cmdlet.
#>
Describe "New-LegalAddress" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new legal address" {
		$legalAddress = New-AgicapLegalAddress -City " " -Country " " -StreetName " "
		$legalAddress.IsEmpty | Should-BeTrue
		$legalAddress.Number | Should-BeNull
		$legalAddress.PostalCode | Should-BeNull

		$legalAddress = New-AgicapLegalAddress -City "Paris" -Country "FR" -PostalCode 75000 -StreetName "Rue de la Paix"
		$legalAddress.IsEmpty | Should-BeFalse
		Should-BeString "Paris" $legalAddress.City -CaseSensitive
		Should-BeString 75000 $legalAddress.PostalCode
		Should-BeString "Rue de la Paix" $legalAddress.StreetName -CaseSensitive
	}
}
