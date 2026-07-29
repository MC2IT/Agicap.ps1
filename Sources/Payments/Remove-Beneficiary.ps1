using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new beneficiary.
.OUTPUTS
	The newly created beneficiary.
#>
# function Remove-Beneficiary {
# 	[CmdletBinding()]
# 	[OutputType([Mc2it.Agicap.Payments.Beneficiary])]
# 	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
# 	param (
# 		# The name of the beneficiary.
# 		[Parameter(Mandatory, Position = 1)]
# 		[string] $Name,

# 		# The bank account of the beneficiary.
# 		[BankAccount] $BankAccount,

# 		# The postal address of the beneficiary.
# 		[switch] $All
# 	)

# 	return [Beneficiary]@{
# 		BankAccount = $BankAccount
# 		Name = $Name
# 		PostalAddress = $PostalAddress
# 	}
# }
