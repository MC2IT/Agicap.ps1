using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Organizations
using namespace System.Collections.Generic
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the organization list.
.OUTPUTS
	The organization list.
#>
function Select-Organization {
	[CmdletBinding(DefaultParameterSetName = "Pagination")]
	[OutputType([Mc2it.Agicap.Organizations.Organization])]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.Organizations.Organization]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The page number.
		[Parameter(ParameterSetName = "Pagination")]
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[Parameter(ParameterSetName = "Pagination")]
		[ValidateRange("Positive")]
		[int] $PageSize = 100,

		# Value indicating whether to fetch all organizations.
		[Parameter(ParameterSetName = "All")]
		[switch] $All
	)

	begin {
		$api = $Client.Organizations
	}

	process {
		try {
			$list = $api.GetAll($PageNumber, $PageSize)
			if (-not $All) { return $list }

			$items = [List[Organization]]::new($list.Items)
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
}
