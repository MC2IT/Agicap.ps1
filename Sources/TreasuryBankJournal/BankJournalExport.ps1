using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.TreasuryBankJournal
using namespace System.Diagnostics.CodeAnalysis
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

<#
.SYNOPSIS
	Creates a new bank journal export request.
.OUTPUTS
	The newly created bank journal export request.
#>
function New-BankJournalExportCounts {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.TreasuryBankJournal.BankJournalExportCounts])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	[SuppressMessage("PSUseSingularNouns", "")]
	param (
		# The number of bank journal entries previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positive")]
		[int] $CurrentBankJournalEntriesCountInYear,

		# The number of bank journal previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positive")]
		[int] $CurrentBankJournalsCountInYear
	)

	return [BankJournalExportCounts]@{
		CurrentBankJournalEntriesCountInYear = $CurrentBankJournalEntriesCountInYear
		CurrentBankJournalsCountInYear = $CurrentBankJournalsCountInYear
	}
}

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

<#
.SYNOPSIS
	Exports all bank journal entries ready to be exported.
.OUTPUTS
	The bank journal entries ready to be exported, or `$null` if there are no entries.
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
