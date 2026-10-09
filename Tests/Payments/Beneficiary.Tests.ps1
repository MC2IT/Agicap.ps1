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
		$beneficiary.Name | Should-BeString "My Company" -CaseSensitive
		$beneficiary.BankAccount | Should-BeNull
		$beneficiary.Id | Should-Be (New-Guid -Empty)
		$beneficiary.PostalAddress | Should-BeNull
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
		$list.Count | Should-BeGreaterThan 1

		$beneficiary = $list | Where-Object { $_.Name -like "Agicap*" }
		Should-NotBeNull $beneficiary.PostalAddress
		$beneficiary.PostalAddress.City | Should-BeString Lyon
		$beneficiary.PostalAddress.Country | Should-BeString FR -CaseSensitive
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
		$beneficiary.Id | Should-Be (New-Guid -Empty)
		$beneficiary | Submit-AgicapBeneficiary $client $entityId -ErrorAction Stop | Out-Null
		$beneficiary.Id | Should-NotBe (New-Guid -Empty)
	}

	It "should throw an exception if the beneficiary already exists" {
		try {
			$beneficiary | Submit-AgicapBeneficiary $client $entityId -ErrorAction Stop | Out-Null
			throw "The exception was not thrown as planned."
		}
		catch [Mc2it.Agicap.HttpResponseException] {
			$_.Exception.StatusCode | Should-Be ([HttpStatusCode]::Conflict)
			$_.Exception.ProblemDetails.Title | Should-BeLikeString "*beneficiary*MC2IT*exists*"
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
		Should-NotBe (New-Guid -Empty) (Sync-AgicapBeneficiary $client -EntityId $entityId -Beneficiary $beneficiary)
	}
}
