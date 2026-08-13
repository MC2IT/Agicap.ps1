using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

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
		[Parameter(Mandatory, ParameterSetName = "Number", Position = 3)]
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
