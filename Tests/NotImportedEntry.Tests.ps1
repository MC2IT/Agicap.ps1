<#
.SYNOPSIS
	Tests the features of the `New-NotImportedEntry` cmdlet.
#>
Describe "New-NotImportedEntry" {
	BeforeAll { . "$PSScriptRoot/BeforeAll.ps1" }

	It "should return a new entry marked as not imported" {
		$guid = New-Guid
		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_VAT_ACCOUNT "An error occurred."

		$notImportedEntry = New-AgicapNotImportedEntry $guid $notImportedEntryError
		Should-Be $guid $notImportedEntry.EntryAgicapUniqueId
		Should-BeCollection @($notImportedEntryError) $notImportedEntry.Errors
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-NotImportedEntryError` cmdlet.
#>
Describe "New-NotImportedEntryError" {
	BeforeAll { . "$PSScriptRoot/BeforeAll.ps1" }

	It "should return a new entry import error" {
		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_CURRENCY
		Should-BeNull $notImportedEntryError.ErrorMessage
		Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownCurrency) $notImportedEntryError.ErrorType -CaseSensitive

		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_THIRD_PARTY "An error occurred."
		Should-BeString "An error occurred." $notImportedEntryError.ErrorMessage -CaseSensitive
		Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownThirdParty) $notImportedEntryError.ErrorType -CaseSensitive
	}
}
