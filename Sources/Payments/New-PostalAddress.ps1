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
		# The name of the city.
		[string] $City = "",

		# The ISO 3166 alpha-2 code of the country in which the beneficiary is located.
		[string] $Country = "",

		# The number of the building.
		[string] $Number = "",

		# The state in which the beneficiary is located.
		[string] $State = "",

		# The name of the street.
		[string] $StreetName = "",

		# The ZIP code of the beneficiary location.
		[string] $ZipCode = ""
	)

	[PostalAddress]@{
		City = $City
		Country = $Country
		Number = $Number
		State = $State
		StreetName = $StreetName
		ZipCode = $ZipCode
	}
}
