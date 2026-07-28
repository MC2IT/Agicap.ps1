<#
.SYNOPSIS
	Tests the features of the `Select-Organization` cmdlet.
#>
Describe "Select-Organization" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the list of all organizations" -Skip:($Env:CI -eq "true") {
		$list = Select-AgicapOrganization $client
		Should-BeCollection $list.Items -Count 1
		Should-Be $list.Items.Count $list.Pagination.TotalItemsCount

		$organization = $list.Items[0]
		Should-Be $organizationId $organization.Id
		Should-BeString MC2IT $organization.Name -CaseSensitive
	}
}
