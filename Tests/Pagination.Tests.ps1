using namespace System.Diagnostics.CodeAnalysis
using module ../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Pagination` class.
#>
Describe "Pagination" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../Resources/Pagination.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create a pagination from the specified JSON payload" {
			$pagination = [Mc2it.Agicap.Pagination] $json
			Should-Be 18 $pagination.CurrentPageItemsCount
			Should-Be 2 $pagination.CurrentPageNumber
			Should-BeFalse $pagination.HasNextPage
			Should-BeTrue $pagination.HasPreviousPage
			Should-Be 2 $pagination.PagesCount
			Should-Be 33 $pagination.PageSize
			Should-Be 51 $pagination.TotalItemsCount
		}
	}
}
