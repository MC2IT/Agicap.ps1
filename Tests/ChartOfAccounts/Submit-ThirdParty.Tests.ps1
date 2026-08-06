using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Tests the features of `Submit-ThirdParty` and `Remove-ThirdParty` cmdlets.
#>
Describe "Submit-ThirdParty" -Skip:($Env:CI -eq "true") {
	BeforeAll {
		. "$PSScriptRoot/../BeforeAll.ps1"
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "thirdParty")]
		$thirdParty = New-AgicapThirdParty "MC2IT-DEVELOPMENT" "MC2IT Development Department $(New-Guid)" -AccountingAccountNumber 41100000
	}

	It "should create or update the specified third party" {
		$importResponse = $thirdParty | Submit-AgicapThirdParty $client $entityId -ErrorAction Stop
		while ($importResponse.ImportStatus -eq "Started") {
			Start-Sleep 2.5
			$importResponse = $thirdParty | Submit-AgicapThirdParty $client $entityId -ImportId $importResponse.ImportId -ErrorAction Stop
		}

		Should-Be ([Mc2it.Agicap.ChartOfAccounts.ImportStatus]::Done) $importResponse.ImportStatus
		Should-Be 0 $importResponse.ImportSummary?.NotImportedCount
	}

	It "should delete the specified third party" {
		$thirdParty | Remove-AgicapThirdParty $client $entityId
	}
}
