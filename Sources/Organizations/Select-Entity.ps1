using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Organizations
using namespace System.Collections.Generic
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the entities of the organization with the specified identifier.
.OUTPUTS
	The entities of the organization with the specified identifier.
#>
function Select-Entity {
	[CmdletBinding(DefaultParameterSetName = "Pagination")]
	[OutputType([Mc2it.Agicap.Organizations.Entity])]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.Organizations.Entity]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The organization identifier.
		[Parameter(Mandatory, Position = 2)]
		[guid] $OrganizationÌd,

		# The page number.
		[Parameter(ParameterSetName = "Pagination")]
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[Parameter(ParameterSetName = "Pagination")]
		[ValidateRange("Positive")]
		[int] $PageSize = 100,

		# Value indicating whether to fetch all entities.
		[Parameter(ParameterSetName = "All")]
		[switch] $All
	)

	try {
		$api = $Client.Organizations.Entities($OrganizationÌd)
		$list = $api.GetAll($PageNumber, $PageSize)
		if (-not $All) { return $list }

		$items = [List[Entity]]::new($list.Items)
		while ($list.Pagination.CurrentPageNumber -lt $list.Pagination.PagesCount) {
			$list = $api.GetAll(++$PageNumber, $PageSize)
			$items.AddRange($list.Items)
		}

		$items
	}
	catch [HttpRequestException] {
		Write-Error $_
	}
}
