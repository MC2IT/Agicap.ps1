using namespace Mc2it.Agicap.Suppliers
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new supplier.
.OUTPUTS
	The newly created supplier.
#>
function New-Supplier {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.Suppliers.Supplier])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The identifier of the supplier in the ERP software.
		[Parameter(Position = 1)]
		[string] $ErpId,

		# The display name.
		[Parameter(Position = 2)]
		[string] $Name,

		# The contacts of this supplier.
		[ValidateNotNull()]
		[Contact[]] $Contacts = @(),

		# The ISO 639-1 code of the supplier preferred language.
		[string] $Language,

		# The legal address of this supplier.
		[LegalAddress] $LegalAddress,

		# The legal registration identifier (e.g. LEI, SIRET, company number...).
		[string] $LegalCompanyId,

		# The legal name of this supplier, when it differs from the display name.
		[string] $LegalName,

		# The primary contact of this supplier.
		[Contact] $PrimaryContact,

		# The lifecycle status of this supplier, as pushed by the ERP software.
		[string] $Status,

		# The tags associated with this supplier.
		[ValidateNotNull()]
		[string[]] $Tags = @(),

		# The third-party accounting code of this supplier.
		[string] $ThirdPartyCode,

		# The VAT code of this supplier.
		[string] $VatCode
	)

	return [Supplier]@{
		Contacts = $Contacts.Count ? $Contacts : $null
		ErpId = $ErpId ? $ErpId : [NullString]::Value
		Language = $Language ? $Language : [NullString]::Value
		LegalAddress = $LegalAddress
		LegalCompanyId = $LegalCompanyId ? $LegalCompanyId : [NullString]::Value
		LegalName = $LegalName ? $LegalName : [NullString]::Value
		Name = $Name ? $Name : [NullString]::Value
		PrimaryContact = $PrimaryContact
		Status = $Status ? $Status : [NullString]::Value
		Tags = $Tags.Count ? $Tags : $null
		ThirdPartyCode = $ThirdPartyCode ? $ThirdPartyCode : [NullString]::Value
		VatCode = $VatCode ? $VatCode : [NullString]::Value
	}
}
