using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the entities of the organization with the specified identifier.
.OUTPUTS
	The entities of the organization with the specified identifier.
#>
function Select-Entity {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.Organizations.Entity]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The organization identifier.
		[Parameter(Mandatory, Position = 2)]
		[guid] $OrganizationÌd,

		# The page number.
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[ValidateRange(2, 100)]
		[int] $PageSize = 100
	)

	begin {
		$api = $Client.Organizations.Entities($OrganizationÌd)
	}

	process {
		try { $api.ReadAll($PageNumber, $PageSize) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
