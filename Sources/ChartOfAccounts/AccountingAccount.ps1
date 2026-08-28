using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Creates a new accounting account.
.OUTPUTS
	The newly created accounting account.
#>
function New-AccountingAccount {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.ChartOfAccounts.AccountingAccount])]
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

<#
.SYNOPSIS
	Deletes the accounting accounts with the specified numbers.
.INPUTS
	The accounting accounts to delete.
#>
function Remove-AccountingAccount {
	[CmdletBinding(DefaultParameterSetName = "InputObject")]
	[OutputType([void])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The accounting accounts to delete.
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[AccountingAccount[]] $InputObject,

		# The numbers of accounting accounts to delete.
		[Parameter(Mandatory, ParameterSetName = "AccountingAccountNumber", Position = 3)]
		[string[]] $AccountingAccountNumber
	)

	begin {
		$api = $Client.ChartOfAccounts.AccountingAccounts($EntityId)
	}

	process {
		try { $api.Delete($InputObject ?? $AccountingAccountNumber) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Creates new accounting accounts.
.INPUTS
	The accounting accounts to create.
.OUTPUTS
	Metrics about the import of accounting accounts.
#>
function Submit-AccountingAccount {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.ChartOfAccounts.ImportResponse])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The accounting accounts to create.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[AccountingAccount[]] $InputObject,

		# The identifier to assign to the import.
		[guid] $ImportId = (New-Guid)
	)

	begin {
		$api = $Client.ChartOfAccounts.AccountingAccounts($EntityId)
	}

	process {
		try { $api.Create($InputObject, $ImportId) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
