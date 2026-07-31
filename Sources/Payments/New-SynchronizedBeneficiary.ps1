using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new beneficiary for a synchronization request.
.OUTPUTS
	The newly created beneficiary.
#>
function New-SynchronizedBeneficiary {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.SynchronizedBeneficiary])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The identifier of the beneficiary in the ERP software.
		[Parameter(Mandatory, Position = 1)]
		[string] $ErpId,

		# The beneficiary to synchronize.
		[Parameter(Mandatory, Position = 2)]
		[Beneficiary] $Beneficiary,

		# The ERP identifiers of the suppliers to associate with this beneficiary.
		[ValidateNotNull()]
		[string[]] $SupplierErpId = @()
	)

	$synchronizedBeneficiary = [SynchronizedBeneficiary]::new($ErpId, $Beneficiary)
	if ($SupplierErpId.Count) { $synchronizedBeneficiary.SupplierErpIds = $SupplierErpId }
	$synchronizedBeneficiary
}
