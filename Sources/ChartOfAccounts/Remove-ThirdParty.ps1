using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Deletes the third-parties with the specified codes.
.INPUTS
	The third-parties to delete.
#>
function Remove-ThirdParty {
	[CmdletBinding(DefaultParameterSetName = "InputObject")]
	[OutputType([void])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The third-parties to delete.
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[ThirdParty[]] $InputObject,

		# The codes of third-parties to delete.
		[Parameter(Mandatory, ParameterSetName = "ThirdPartyCode", Position = 3)]
		[string[]] $ThirdPartyCode
	)

	begin {
		$api = $Client.ChartOfAccounts.ThirdParties($EntityId)
	}

	process {
		try { $api.Delete($InputObject ?? $ThirdPartyCode) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
