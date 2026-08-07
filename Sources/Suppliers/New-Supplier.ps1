using namespace Mc2it.Agicap.Suppliers
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new supplier.
.OUTPUTS
	The newly created supplier.
#>
function New-Supplier {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Suppliers.Supplier])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The contacts of the supplier.
		[Contact[]] $Contact
	)

	return [Contact]@{
		Contacts = $Contact
	}
}
