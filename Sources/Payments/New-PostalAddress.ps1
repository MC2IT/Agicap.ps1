using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new postal address.
.OUTPUTS
	The newly created postal address.
#>
function New-PostalAddress {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.PostalAddress])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The number of the building.
		[string] $Number,

		# The name of the street.
		[Parameter(Mandatory)]
		[AllowEmptyString()]
		[string] $StreetName,

		# The name of the city.
		[Parameter(Mandatory)]
		[AllowEmptyString()]
		[string] $City,

		# The ZIP code of the beneficiary location.
		[string] $ZipCode,

		# The state in which the beneficiary is located.
		[string] $State,

		# The ISO 3166 alpha-2 code of the country in which the beneficiary is located.
		[Parameter(Mandatory)]
		[AllowEmptyString()]
		[string] $Country
	)

	return [PostalAddress]@{
		City = $City
		Country = $Country
		Number = $Number ? $Number : [NullString]::Value
		State = $State ? $State : [NullString]::Value
		StreetName = $StreetName
		ZipCode = $ZipCode ? $ZipCode : [NullString]::Value
	}
}
