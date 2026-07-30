using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the beneficiaries of the entity with the specified identifier.
.OUTPUTS
	The beneficiaries of the entity with the specified identifier.
#>
function Select-Beneficiary {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.Beneficiary])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try { $api.ReadAll() }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
