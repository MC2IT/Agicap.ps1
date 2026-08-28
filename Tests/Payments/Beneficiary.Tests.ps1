using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net

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
		Should-Be (New-Guid -Empty) $beneficiary.Id
		Should-BeNull $beneficiary.PostalAddress
	}
}

<#
.SYNOPSIS
	Tests the features of the `Select-Beneficiary` cmdlet.
#>
Describe "Select-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the beneficiaries of the entity with the specified identifier" {
		$list = Select-AgicapBeneficiary $client $entityId
		Should-BeGreaterThan 1 $list.Count

		$beneficiary = $list.Where{ $_.Name -like "Agicap*" }
		Should-NotBeNull $beneficiary.PostalAddress
		Should-BeString Lyon $beneficiary.PostalAddress.City
		Should-BeString FR $beneficiary.PostalAddress.Country -CaseSensitive
	}
}

<#
.SYNOPSIS
	Tests the features of `Submit-Beneficiary`, `Update-Beneficiary` and `Remove-Beneficiary` cmdlets.
#>
Describe "Submit-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll {
		. "$PSScriptRoot/../BeforeAll.ps1"
		$postalAddress = New-AgicapPostalAddress -City "Fabrègues" -Country FR -StreetName "Rue Gine"
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "beneficiary")]
		$beneficiary = New-AgicapBeneficiary "MC2IT Test Runner" -PostalAddress $postalAddress
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
		$beneficiary | Update-AgicapBeneficiary $client $entityId -ErrorAction Stop
	}

	It "should delete the specified beneficiary" {
		$beneficiary | Remove-AgicapBeneficiary $client $entityId -ErrorAction Stop
	}
}

<#
.SYNOPSIS
	Tests the features of the `Sync-Beneficiary` cmdlet.
#>
Describe "Sync-Beneficiary" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should synchronize the specified beneficiary" {
		$postalAddress = New-AgicapPostalAddress -City "Fabrègues" -Country FR -StreetName "Rue Gine"
		$beneficiary = New-AgicapSynchronizedBeneficiary "MC2IT-DEVELOPMENT" (New-AgicapBeneficiary "MC2IT Development Department" -PostalAddress $postalAddress)
		Should-NotBe (New-Guid -Empty) (Sync-AgicapBeneficiary $client $entityId $beneficiary)
	}
}
