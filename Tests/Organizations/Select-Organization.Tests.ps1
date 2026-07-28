<#
.SYNOPSIS
	Tests the features of the `Select-Organization` cmdlet.
#>
Describe "Select-Organization" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the organization list" {
		$list = Select-AgicapOrganization $client
		Should-BeCollection $list.Items -Count 1
		Should-Be $list.Items.Count $list.Pagination.TotalItemsCount

		$organization = $list.Items[0]
		Should-Be $organizationId $organization.Id
		Should-BeString MC2IT $organization.Name -CaseSensitive
	}

	It "should support fetching all organizations in one pass" {
		$list = @(Select-AgicapOrganization $client -All)
		Should-BeCollection $list -Count 1

		$organization = $list[0]
		Should-Be $organizationId $organization.Id
		Should-BeString MC2IT $organization.Name -CaseSensitive
	}
}
