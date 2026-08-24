using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the exports of the treasury bank journal.
.OUTPUTS
	The exports of the treasury bank journal.
#>
function Select-BankJournalExport {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.CursorPaginatedList[Mc2it.Agicap.TreasuryBankJournal.BankJournalExportSummary]])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The number of bank journal entries to fetch.
		[ValidateRange("Positive")]
		[int] $Size = 100,

		# The export start date.
		[Parameter(ParameterSetName = "After")]
		[Nullable[datetime]] $After,

		# The export end date.
		[Parameter(ParameterSetName = "Before")]
		[Nullable[datetime]] $Before
	)

	begin {
		$api = $Client.TreasuryBankJournal.Exports($EntityId)
	}

	end {
		try { $api.ReadAll($Size, $After, $Before) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
