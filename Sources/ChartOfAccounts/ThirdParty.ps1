using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Creates a new third-party.
.OUTPUTS
	The newly created third-party.
#>
function New-ThirdParty {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.ChartOfAccounts.ThirdParty])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The code of the third-party.
		[Parameter(Mandatory, Position = 1)]
		[string] $ThirdPartyCode,

		# The name of the third-party.
		[Parameter(Mandatory, Position = 2)]
		[string] $ThirdPartyName,

		# The accounting account number.
		[Parameter(Mandatory)]
		[string] $AccountingAccountNumber,

		# An optional ERP-specific external identifier.
		[string] $ExternalId
	)

	return [ThirdParty]@{
		AccountingAccountNumber = $AccountingAccountNumber
		ExternalId = $ExternalId ? $ExternalId : [NullString]::Value
		ThirdPartyCode = $ThirdPartyCode
		ThirdPartyName = $ThirdPartyName
	}
}

<#
.SYNOPSIS
	Deletes the third-parties with the specified codes.
.INPUTS
	The third-parties to delete.
#>
function Remove-ThirdParty {
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

		# The third-parties to delete.
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[ThirdParty[]] $InputObject,

		# The codes of third-parties to delete.
		[Parameter(Mandatory, ParameterSetName = "ThirdPartyCode", Position = 3)]
		[string[]] $ThirdPartyCode
	)

	begin {
		$api = $Client.ChartOfAccounts.ThirdParties($EntityId)
	}

	process {
		try { $api.Delete($InputObject ?? $ThirdPartyCode) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Creates new third-parties.
.INPUTS
	The third-parties to create.
.OUTPUTS
	Metrics about the import of third-parties.
#>
function Submit-ThirdParty {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.ChartOfAccounts.ImportResponse])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The third-parties to create.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[ThirdParty[]] $InputObject,

		# The identifier to assign to the import.
		[guid] $ImportId = (New-Guid)
	)

	begin {
		$api = $Client.ChartOfAccounts.ThirdParties($EntityId)
	}

	process {
		try { $api.Create($InputObject, $ImportId) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
