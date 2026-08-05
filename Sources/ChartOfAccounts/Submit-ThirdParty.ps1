using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Net.Http

<#
.SYNOPSIS
	Creates new third-parties.
.INPUTS
	The third-parties to create.
.OUTPUTS
	Metrics about the import of third-parties.
#>
function Submit-ThirdParty {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.ChartOfAccounts.ImportResponse])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The third-parties to create.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[ThirdParty[]] $InputObject
	)

	begin {
		$api = $Client.ChartOfAccounts.ThirdParties($EntityId)
	}

	process {
		try { $api.Create($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
