using namespace Mc2it.Agicap

<#
.SYNOPSIS
	Fetches the entities of the organization with the specified identifier.
.OUTPUTS
	The entities of the organization with the specified identifier.
#>
function Select-OrganizationEntity {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.Organizations.Entity]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The organization identifier.
		[Parameter(Mandatory, Position = 2)]
		[guid] $Organization,

		# The page number.
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[ValidateRange("Positive")]
		[int] $PageSize = 100
	)

	$Client.Organizations.GetEntities($Organization, $PageNumber, $PageSize)
}
