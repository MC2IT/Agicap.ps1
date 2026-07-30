using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments

<#
.SYNOPSIS
	Creates a new beneficiary.
.INPUTS
	The beneficiary to create.
#>
function Submit-Beneficiary {
	[CmdletBinding()]
	[OutputType([void])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The beneficiary to create.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try { $api.Create($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
