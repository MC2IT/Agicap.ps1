using namespace Mc2it.Agicap.TreasuryBankJournal
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new bank journal export request.
.OUTPUTS
	The newly created bank journal export request.
#>
function New-BankJournalExportRequest {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.TreasuryBankJournal.BankJournalExportRequest])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The number of bank journal entries previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positiive")]
		[int] $CurrentBankJournalEntriesCountInYear,

		# The number of bank journal previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positiive")]
		[int] $CurrentBankJournalsCountInYear
	)

	return [BankJournalExportRequest]@{
		CurrentBankJournalEntriesCountInYear = $CurrentBankJournalEntriesCountInYear
		CurrentBankJournalsCountInYear = $CurrentBankJournalsCountInYear
	}
}
