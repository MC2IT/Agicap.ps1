using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Net.Http

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
		[AccountingAccount[]] $InputObject
	)

	begin {
		$api = $Client.ChartOfAccounts.AccountingAccounts($EntityId)
	}

	process {
		try { $api.Create($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
