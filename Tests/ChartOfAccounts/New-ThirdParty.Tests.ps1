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
