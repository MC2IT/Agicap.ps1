<#
.SYNOPSIS
	Tests the features of the `New-NotImportedEntryError` cmdlet.
#>
Describe "New-NotImportedEntryError" {
	BeforeAll { . "$PSScriptRoot/BeforeAll.ps1" }

	It "should return a new entry error" {
		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_CURRENCY
		Should-BeNull $notImportedEntryError.ErrorMessage
		Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownCurrency) $notImportedEntryError.ErrorType -CaseSensitive

		$notImportedEntryError = New-AgicapNotImportedEntryError UNKNOWN_THIRD_PARTY "An error occurred."
		Should-BeString "An error occurred." $notImportedEntryError.ErrorMessage -CaseSensitive
		Should-BeString ([Mc2it.Agicap.NotImportedEntryErrorTypes]::UnknownThirdParty) $notImportedEntryError.ErrorType -CaseSensitive
	}
}
