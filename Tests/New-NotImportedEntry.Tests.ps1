<#
.SYNOPSIS
	Tests the features of the `New-NotImportedEntry` cmdlet.
#>
Describe "New-NotImportedEntry" {
	BeforeAll { . "$PSScriptRoot/BeforeAll.ps1" }

	It "should return a new entry" {
		$guid = New-Guid
		$importErrror = New-AgicapNotImportedEntryError UNKNOWN_VAT_ACCOUNT "An error occurred."

		$notImportedEntry = New-AgicapNotImportedEntry $guid $importErrror
		Should-Be $guid $notImportedEntry.EntryAgicapUniqueId
		Should-BeCollection @($importErrror) $notImportedEntry.Errors
	}
}
