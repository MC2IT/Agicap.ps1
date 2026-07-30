using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments
using namespace System.Net.Http

<#
.SYNOPSIS
	Updates the specified beneficiary.
.INPUTS
	The beneficiary to update.
#>
function Update-Beneficiary {
	[CmdletBinding()]
	[OutputType([void])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The beneficiary to update.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try { $api.Update($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
