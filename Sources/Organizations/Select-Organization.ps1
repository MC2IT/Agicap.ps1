using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the organization list.
.OUTPUTS
	The organization list.
#>
function Select-Organization {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.Organizations.Organization]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The page number.
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[ValidateRange("Positive")]
		[int] $PageSize = 100
	)

	begin {
		$api = $Client.Organizations
	}

	process {
		try { $api.ReadAll($PageNumber, $PageSize) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
