using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments
using namespace System.Net.Http

<#
.SYNOPSIS
	Starts a bulk synchronization of beneficiaries from the ERP software.
.OUTPUTS
	The identifier of the newly started synchronization.
#>
function Sync-Beneficiary {
	[CmdletBinding()]
	[OutputType([guid])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The beneficiaries to synchronize.
		[Parameter(Mandatory, Position = 3)]
		[SynchronizedBeneficiary[]] $Beneficiaries
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId).Synchronization
	}

	process {
		try { $api.Create($Beneficiaries) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
