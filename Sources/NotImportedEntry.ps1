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

<#
.SYNOPSIS
	Creates a new import error for a purchase journal entry.
.OUTPUTS
	The newly created entry error.
#>
function New-NotImportedEntryError {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.NotImportedEntryError])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The error type.
		[Parameter(Mandatory, Position = 1)]
		[ValidateSet("OTHER", "UNKNOWN_ANALYTICAL_CODE", "UNKNOWN_CURRENCY", "UNKNOWN_EXPENSE_ACCOUNT", "UNKNOWN_THIRD_PARTY", "UNKNOWN_VAT_ACCOUNT")]
		[string] $ErrorType,

		# A message describing the error.
		[Parameter(Position = 2)]
		[string] $ErrorMessage
	)

	return [NotImportedEntryError]@{
		ErrorMessage = $ErrorMessage ? $ErrorMessage : [NullString]::Value
		ErrorType = $ErrorType
	}
}
