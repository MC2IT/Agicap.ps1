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
