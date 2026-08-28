<#
.SYNOPSIS
	Tests the features of the `New-LegalAddress` cmdlet.
#>
Describe "New-LegalAddress" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new legal address" {
		$legalAddress = New-AgicapLegalAddress -City " " -Country " " -StreetName " "
		Should-BeTrue $legalAddress.IsEmpty
		Should-BeNull $legalAddress.Number
		Should-BeNull $legalAddress.PostalCode

		$legalAddress = New-AgicapLegalAddress -City "Paris" -Country "FR" -PostalCode 75000 -StreetName "Rue de la Paix"
		Should-BeFalse $legalAddress.IsEmpty
		Should-BeString "Paris" $legalAddress.City -CaseSensitive
		Should-BeString 75000 $legalAddress.PostalCode
		Should-BeString "Rue de la Paix" $legalAddress.StreetName -CaseSensitive
	}
}
