using namespace Mc2it.Agicap
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new purchase journal entry that was not imported in the client accounting system.
.OUTPUTS
	The newly created entry.
#>
function New-NotImportedEntry {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.NotImportedEntry])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# A unique identifier from Agicap.
		[Parameter(Mandatory, Position = 1)]
		[guid] $EntryAgicapUniqueId,

		# The errors preventing the journal entry from being imported.
		[Parameter(Mandatory, Position = 2)]
		[NotImportedEntryError[]] $Errors
	)

	return [NotImportedEntry]@{
		EntryAgicapUniqueId = $EntryAgicapUniqueId
		Errors = $Errors
	}
}
