using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new accounting account.
.OUTPUTS
	The newly created accounting account.
#>
function New-AccountingAccount {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.AccountingAccount])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The accounting account number.
		[Parameter(Mandatory, Position = 1)]
		[string] $AccountingAccountNumber,

		# The accounting account name.
		[Parameter(Mandatory, Position = 2)]
		[string] $AccountingAccountName,

		# The accounting account type.
		[Nullable[AccountingAccountType]] $AccountingAccountType,

		# An optional ERP-specific external identifier.
		[string] $ExternalId,

		# The tax key.
		[string] $TaxKey,

		# The VAT rate.
		[Nullable[double]] $VatRate
	)

	return [AccountingAccount]@{
		AccountingAccountName = $AccountingAccountName
		AccountingAccountNumber = $AccountingAccountNumber
		AccountingAccountType = $AccountingAccountType
		ExternalId = $ExternalId ? $ExternalId : [NullString]::Value
		TaxKey = $TaxKey ? $TaxKey : [NullString]::Value
		VatRate = $VatRate
	}
}
