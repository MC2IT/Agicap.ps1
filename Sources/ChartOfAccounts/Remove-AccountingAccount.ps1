using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Deletes the accounting accounts with the specified numbers.
.INPUTS
	The numbers of accounting accounts to delete.
#>
function Remove-AccountingAccount {
	[CmdletBinding()]
	[OutputType([void])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The numbers of accounting accounts to delete.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[string[]] $InputObject
	)

	begin {
		$api = $Client.ChartOfAccounts.AccountingAccounts($EntityId)
	}

	process {
		try { $api.Delete($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
