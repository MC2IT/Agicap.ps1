<#
.SYNOPSIS
	Tests the features of the `Select-Entity` cmdlet.
#>
Describe "Select-Entity" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the entities of the organization with the specified identifier" {
		$list = Select-AgicapEntity $client $organizationId
		$list.Items.Count | Should-BeGreaterThanOrEqual 1
		$list.Pagination.TotalItemsCount | Should-Be $list.Items.Count

		$entity = $list.Items.Where{ $_.Id -eq $entityId }
		$entity.Country | Should-BeString FR -CaseSensitive
		$entity.Name | Should-BeString MC2IT -CaseSensitive
	}
}
