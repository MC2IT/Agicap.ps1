using namespace Mc2it.Agicap.Suppliers
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new legal address.
.OUTPUTS
	The newly created legal address.
#>
function New-LegalAddress {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Suppliers.LegalAddress])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The address number.
		[string] $Number,

		# The street name.
		[string] $StreetName,

		# The name of the city.
		[string] $City,

		# The postal code of the supplier location.
		[string] $PostalCode,

		# The state in which the supplier is located.
		[string] $State,

		# The ISO 3166 alpha-2 code of the country in which the supplier is located.
		[Parameter(Mandatory)]
		[AllowEmptyString()]
		[string] $Country
	)

	return [LegalAddress]@{
		City = $City ? $City : [NullString]::Value
		Country = $Country
		Number = $Number ? $Number : [NullString]::Value
		PostalCode = $PostalCode ? $PostalCode : [NullString]::Value
		State = $State ? $State : [NullString]::Value
		StreetName = $StreetName ? $StreetName : [NullString]::Value
	}
}
