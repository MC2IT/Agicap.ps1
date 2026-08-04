using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net

<#
.SYNOPSIS
	Tests the features of `Submit-Beneficiary`, `Update-Beneficiary` and `Remove-Beneficiary` cmdlets.
#>
Describe "Submit-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll {
		. "$PSScriptRoot/../BeforeAll.ps1"
		$postalAddress = New-AgicapPostalAddress -City "Fabrègues" -Country FR -StreetName "Rue Gine"
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "beneficiary")]
		$beneficiary = New-AgicapBeneficiary "MC2IT Continuous integration" -PostalAddress $postalAddress
	}

	It "should create the specified beneficiary" {
		Should-Be (New-Guid -Empty) $beneficiary.Id
		$beneficiary | Submit-AgicapBeneficiary $client $entityId -ErrorAction Stop | Out-Null
		Should-NotBe (New-Guid -Empty) $beneficiary.Id
	}

	It "should throw an exception if the beneficiary already exists" {
		try {
			$beneficiary | Submit-AgicapBeneficiary $client $entityId -ErrorAction Stop | Out-Null
			throw "The exception was not thrown as planned."
		}
		catch [Mc2it.Agicap.HttpResponseException] {
			Should-Be ([HttpStatusCode]::Conflict) $_.Exception.StatusCode
			Should-BeLikeString "*beneficiary*MC2IT*exists*" $_.Exception.ProblemDetails?.Title
		}
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
