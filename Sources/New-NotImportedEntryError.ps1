using namespace Mc2it.Agicap
using namespace System.Diagnostics.CodeAnalysis

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
