using namespace Mc2it.Agicap

<#
.SYNOPSIS
	Fetches the list of all organizations.
.OUTPUTS
	The list of all organizations.
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

	$Client.Organizations.GetOrganizations($PageNumber, $PageSize)
}
