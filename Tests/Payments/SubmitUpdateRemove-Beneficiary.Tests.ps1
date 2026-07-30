using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Tests the features of `Submit-Beneficiary`, `Update-Beneficiary` and `Remove-Beneficiary` cmdlets.
#>
Describe "SubmitUpdateRemove-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll {
		. "$PSScriptRoot/../BeforeAll.ps1"
		$postalAddress = New-AgicapPostalAddress -City "Fabrègues" -Country "FR" -StreetName "Rue Gine"
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "beneficiary")]
		$beneficiary = New-AgicapBeneficiary "MC2IT Service Développement" -PostalAddress $postalAddress
	}

	It "should create the specified beneficiary" {
		Should-Be (New-Guid -Empty) $beneficiary.Id
		$beneficiary | Submit-AgicapBeneficiary $client $entityId | Out-Null
		Should-NotBe (New-Guid -Empty) $beneficiary.Id
	}

	It "should update the specified beneficiary" {
		$beneficiary.PostalAddress.Number = "29"
		$beneficiary.PostalAddress.ZipCode = "34690"
		$beneficiary | Update-AgicapBeneficiary $client $entityId
	}

	It "should delete the specified beneficiary" {
		$beneficiary | Remove-AgicapBeneficiary $client $entityId
	}
}
