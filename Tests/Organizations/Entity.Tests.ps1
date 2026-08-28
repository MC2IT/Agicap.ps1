<#
.SYNOPSIS
	Tests the features of the `Select-Entity` cmdlet.
#>
Describe "Select-Entity" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return the entities of the organization with the specified identifier" {
		$list = Select-AgicapEntity $client $organizationId
		Should-BeGreaterThanOrEqual 1 $list.Items.Count
		Should-Be $list.Items.Count $list.Pagination.TotalItemsCount

		$entity = $list.Items.Where{ $_.Id -eq $entityId }
		Should-BeString FR $entity.Country -CaseSensitive
		Should-BeString MC2IT $entity.Name -CaseSensitive
	}
}
