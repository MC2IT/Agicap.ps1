using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Tests the features of the `New-ThirdParty` cmdlet.
#>
Describe "New-ThirdParty" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new third-party" {
		$thirdParty = New-AgicapThirdParty "MC2IT-DEVELOPMENT" "MC2IT Development Department" -AccountingAccountNumber 41100000
		Should-BeString 41100000 $thirdParty.AccountingAccountNumber
		Should-BeNull $thirdParty.ExternalId
		Should-BeString "MC2IT-DEVELOPMENT" $thirdParty.ThirdPartyCode -CaseSensitive
		Should-BeString "MC2IT Development Department" $thirdParty.ThirdPartyName -CaseSensitive

		$thirdParty.ExternalId = 123456
		Should-BeString "123456" $thirdParty.ExternalId
	}
}

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
		$thirdParty | Remove-AgicapThirdParty $client $entityId -ErrorAction Stop
	}
}
