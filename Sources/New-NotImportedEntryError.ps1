<#
.SYNOPSIS
	Creates a new Agicap API client.
.INPUTS
	The client identifier and secret.
.OUTPUTS
	The newly created client.
#>
function New-NotImportedEntryError {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.NotImportedEntryError])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		[Parameter(Mandatory, Position = 1)]
		[ValidateSet("OTHER", "UNKNOWN_ANALYTICAL_CODE", "UNKNOWN_CURRENCY", "UNKNOWN_EXPENSE_ACCOUNT", "UNKNOWN_THIRD_PARTY", "UNKNOWN_VAT_ACCOUNT")]
		[string] $ErrorType,

		[Parameter(Position = 2)]
		[string] $ErrorMessage
	)

	[NotImportedEntryError]@{
		ErrorMessage = $ErrorMessage ? $ErrorMessage : [NullString]::Value
		ErrorType = $ErrorType
	}
}
