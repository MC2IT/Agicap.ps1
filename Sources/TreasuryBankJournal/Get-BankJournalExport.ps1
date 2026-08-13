using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Fetches the bank journal export with the specified identifier.
.INPUTS
	The identifier of the bank journal export.
.OUTPUTS
	The bank journal export with the specified identifier.
#>
function Get-BankJournalExport {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.TreasuryBankJournal.BankJournalExport])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The identifier of the bank journal export.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[guid] $ExportId
	)

	begin {
		$api = $Client.TreasuryBankJournal.Exports($EntityId)
	}

	process {
		try { $api.Read($ExportId) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
