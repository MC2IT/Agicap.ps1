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
