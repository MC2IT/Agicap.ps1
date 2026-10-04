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
		$notImportedEntry.EntryAgicapUniqueId | Should-Be $guid
		$notImportedEntry.Errors | Should-BeCollection @($notImportedEntryError)
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
		$notImportedEntryError.ErrorMessage | Should-BeNull
		$notImportedEntryError.ErrorType | Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownCurrency) -CaseSensitive

		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_THIRD_PARTY "An error occurred."
		$notImportedEntryError.ErrorMessage | Should-BeString "An error occurred." -CaseSensitive
		$notImportedEntryError.ErrorType | Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownThirdParty) -CaseSensitive
	}
}
