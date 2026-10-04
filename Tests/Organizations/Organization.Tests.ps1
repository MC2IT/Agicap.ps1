<#
.SYNOPSIS
	Tests the features of the `Select-Organization` cmdlet.
#>
Describe "Select-Organization" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the organization list" {
		$list = Select-AgicapOrganization $client
		$list.Items | Should-BeCollection -Count 1
		$list.Pagination.TotalItemsCount | Should-Be $list.Items.Count

		$organization = $list.Items[0]
		$organization.Id | Should-Be $organizationId
		$organization.Name | Should-BeString MC2IT -CaseSensitive
	}
}
