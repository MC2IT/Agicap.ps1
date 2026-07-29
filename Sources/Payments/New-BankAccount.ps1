using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new bank account.
.OUTPUTS
	The newly created bank account.
#>
function New-BankAccount {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.BankAccount])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The name of the bank the account is located.
		[string] $BankName,

		# The bank identifier code of the bank where the account is located.
		[string] $Bic,

		# The ISO 3166 alpha-2 code of the country of the bank where the account is located.
		[string] $Country,

		# The bank account number (IBAN/BBAN/Other).
		[string] $Identifier,

		# The bank identifier code of the intermediary bank processing the payments.
		[string] $IntermediaryBankBic,

		# The local identifier of the bank.
		[string] $LocalClearingCode
	)

	return [BankAccount]@{
		BankName = $BankName ? $BankName : [NullString]::Value
		Bic = $Bic ? $Bic : [NullString]::Value
		Country = $Country ? $Country : [NullString]::Value
		Identifier = $Identifier ? $Identifier : [NullString]::Value
		IntermediaryBankBic = $IntermediaryBankBic ? $IntermediaryBankBic : [NullString]::Value
		LocalClearingCode = $LocalClearingCode ? $LocalClearingCode : [NullString]::Value
	}
}
