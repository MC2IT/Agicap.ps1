using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Deletes either the specified beneficiary, or all beneficiaries.
.INPUTS
	The beneficiary to delete.
#>
function Remove-Beneficiary {
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

		# The beneficiary to delete.
		[Parameter(Mandatory, ParameterSetName = "BeneficiaryId", Position = 3)]
		[guid] $BeneficiaryId,

		# The beneficiary to delete.
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject,

		# Value indicating whether to delete all beneficiaries.
		[Parameter(ParameterSetName = "All")]
		[switch] $All
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try {
			if ($All) { $api.DeleteAll() }
			else { $api.Delete($InputObject ? $InputObject.Id : $BeneficiaryId) }
		}
		catch [HttpRequestException] {
			Write-Error $_
		}
	}
}
