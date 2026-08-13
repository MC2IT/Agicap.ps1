using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Notifies Agicap that the specified purchase journal entries were not correctly imported in the client accounting system.
.INPUTS
	The purchase journal entry to mark as not imported.
#>
function Deny-AccountingPurchase {
	[CmdletBinding()]
	[OutputType([void])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The purchase journal entry to mark as not imported.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[NotImportedEntry[]] $InputObject
	)

	begin {
		$api = $Client.PurchaseJournal.AccountingPurchases($EntityId)
	}

	process {
		try { $api.MarkAsNotImported($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
