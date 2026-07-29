using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new beneficiary.
.OUTPUTS
	The newly created beneficiary.
#>
function New-Beneficiary {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.Beneficiary])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The bank account of the beneficiary.
		[BankAccount] $BankAccount = $null,

		# The name of the beneficiary.
		[string] $Name = "",

		# The postal address of the beneficiary.
		[PostalAddress] $PostalAddress = $null
	)

	[Beneficiary]@{
		BankAccount = $BankAccount
		Name = $Name
		PostalAddress = $PostalAddress
	}
}
