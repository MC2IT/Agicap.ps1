using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the list of entries in the purchase journal.
.OUTPUTS
	The list of entries in the purchase journal.
#>
function Select-AccountingPurchase {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.PaginatedList[Mc2it.Agicap.PurchaseJournal.PurchaseJournalEntry]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The date of the last synchronization.
		[Parameter(Mandatory, Position = 3)]
		[Nullable[datetime]] $LastSynchronizationDate,

		# The page number.
		[ValidateRange("Positive")]
		[int] $PageNumber = 1,

		# The number of elements per page.
		[ValidateRange("Positive")]
		[int] $PageSize = 100,

		# An opt-in enrichment selector.
		[string] $Include
	)

	begin {
		$api = $Client.PurchaseJournal.AccountingPurchases($EntityId)
	}

	process {
		$date = ${LastSynchronizationDate}?.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
		try { $api.ReadAll($date, $PageNumber, $PageSize, $Include ? $Include : [NullString]::Value) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
