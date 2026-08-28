using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the synchronization report with the specified identifier.
.INPUTS
	The identifier of the synchronization report.
.OUTPUTS
	The synchronization report with the specified identifier.
#>
function Get-BeneficiarySynchronization {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.BeneficiarySynchronization])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The identifier of the synchronization report.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[guid] $SyncId
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId).Synchronization
	}

	process {
		try { $api.Read($SyncId) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
