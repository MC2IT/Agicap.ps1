using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.TreasuryBankJournal
using namespace System.Net.Http

<#
.SYNOPSIS
	Exports all bank journal entries ready to be exported.
.OUTPUTS
	The bank journal export.
#>
function Submit-BankJournalExport {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.TreasuryBankJournal.BankJournalExport])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The identifier to assign to the export.
		[guid] $ExportId = (New-Guid),

		# Optional export parameters allowing to set where to start.
		[BankJournalExportCounts] $CurrentExportCounts
	)

	begin {
		$api = $Client.TreasuryBankJournal.Exports($EntityId)
	}

	end {
		try { $api.Create($ExportId, $CurrentExportCounts) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
