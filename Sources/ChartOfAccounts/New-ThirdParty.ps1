using namespace Mc2it.Agicap.ChartOfAccounts
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new third-party.
.OUTPUTS
	The newly created third-party.
#>
function New-ThirdParty {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.ThirdParty])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The code of the third-party.
		[Parameter(Mandatory, Position = 1)]
		[AllowEmptyString()]
		[string] $ThirdPartyCode,

		# The name of the third-party.
		[Parameter(Mandatory, Position = 2)]
		[AllowEmptyString()]
		[string] $ThirdPartyName,

		# The accounting account number.
		[Parameter(Mandatory)]
		[AllowEmptyString()]
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
