using namespace Mc2it.Agicap.Suppliers
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new contact.
.OUTPUTS
	The newly created contact.
#>
function New-Contact {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Suppliers.Contact])]
	[SuppressMessage("PSUseShouldProcessForRoleChangingFunctions", "")]
	param (
		# The street name.
		[Parameter(Position = 1)]
		[string] $Name,

		# The address number.
		[string] $Email,

		# The postal code of the supplier location.
		[string] $Phone,

		# The state in which the supplier is located.
		[string] $Role
	)

	return [Contact]@{
		Email = $Email ? $Email : [NullString]::Value
		Name = $Name ? $Name : [NullString]::Value
		Phone = $Phone ? $Phone : [NullString]::Value
		Role = $Role ? $Role : [NullString]::Value
	}
}
