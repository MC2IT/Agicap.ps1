using namespace Mc2it.Agicap
using namespace Mc2it.Agicap.Payments
using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net.Http

<#
.SYNOPSIS
	Creates a new beneficiary.
.OUTPUTS
	The newly created beneficiary.
#>
function New-Beneficiary {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.Beneficiary])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The name of the beneficiary.
		[Parameter(Mandatory, Position = 1)]
		[string] $Name,

		# The bank account of the beneficiary.
		[BankAccount] $BankAccount,

		# The postal address of the beneficiary.
		[PostalAddress] $PostalAddress
	)

	return [Beneficiary]@{
		BankAccount = $BankAccount
		Name = $Name
		PostalAddress = $PostalAddress
	}
}

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
		[Parameter(Mandatory, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject,

		# The identifier of the beneficiary to delete.
		[Parameter(Mandatory, ParameterSetName = "BeneficiaryId", Position = 3)]
		[guid] $BeneficiaryId,

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
			else { $api.Delete($InputObject ?? $BeneficiaryId) }
		}
		catch [HttpRequestException] {
			Write-Error $_
		}
	}
}

<#
.SYNOPSIS
	Fetches the beneficiaries of the entity with the specified identifier.
.OUTPUTS
	The beneficiaries of the entity with the specified identifier.
#>
function Select-Beneficiary {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Payments.Beneficiary])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	end {
		try { $api.ReadAll() }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Creates a new beneficiary.
.INPUTS
	The beneficiary to create.
.OUTPUTS
	The identifier of the newly created beneficiary.
#>
function Submit-Beneficiary {
	[CmdletBinding()]
	[OutputType([guid])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The beneficiary to create.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try { $api.Create($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Starts a bulk synchronization of beneficiaries from the ERP software.
.OUTPUTS
	The identifier of the newly started synchronization.
#>
function Sync-Beneficiary {
	[CmdletBinding()]
	[OutputType([guid])]
	param (
		# The API client.
		[Parameter(Mandatory, Position = 1)]
		[Client] $Client,

		# The entity identifier.
		[Parameter(Mandatory, Position = 2)]
		[int] $EntityId,

		# The beneficiaries to synchronize.
		[Parameter(Mandatory, Position = 3)]
		[SynchronizedBeneficiary[]] $Beneficiary
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId).Synchronization
	}

	end {
		try { $api.Create($Beneficiary) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}

<#
.SYNOPSIS
	Updates the specified beneficiary.
.INPUTS
	The beneficiary to update.
#>
function Update-Beneficiary {
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

		# The beneficiary to update.
		[Parameter(Mandatory, Position = 3, ValueFromPipeline)]
		[Beneficiary] $InputObject
	)

	begin {
		$api = $Client.Payments.Beneficiaries($EntityId)
	}

	process {
		try { $api.Update($InputObject) }
		catch [HttpRequestException] { Write-Error $_ }
	}
}
