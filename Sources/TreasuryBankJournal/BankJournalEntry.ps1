using namespace Mc2it.Agicap
using namespace System.Net.Http

<#
.SYNOPSIS
	Notifies Agicap that the specified bank journal entries were successfully imported in the client accounting system.
.INPUTS
	The bank journal entries to mark as imported.
#>
function Approve-BankJournalEntry {
	[CmdletBinding(DefaultParameterSetName = "InputObject")]
	[OutputType([void])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The bank journal entries to mark as imported.
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[ImportedEntry[]] $InputObject,

		# The identifiers of bank journal entries to mark as imported.
		[Parameter(Mandatory, ParameterSetName = "EntryAgicapUniqueId", Position = 3)]
		[guid[]] $EntryAgicapUniqueId
	)

	begin {
		$api = $Client.TreasuryBankJournal.Exports($EntityId)
	}

	process {
		try { $api.MarkAsImported($InputObject ?? $EntryAgicapUniqueId) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Notifies Agicap that the specified bank journal entries were not correctly imported in the client accounting system.
.INPUTS
	The bank journal entries to mark as not imported.
#>
function Deny-BankJournalEntry {
	[CmdletBinding()]
	[OutputType([void])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The bank journal entries to mark as not imported.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[NotImportedEntry[]] $InputObject
	)

	begin {
		$api = $Client.TreasuryBankJournal.Exports($EntityId)
	}

	process {
		try { $api.MarkAsNotImported($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
