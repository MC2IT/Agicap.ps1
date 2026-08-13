using namespace Mc2it.Agicap.TreasuryBankJournal
using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Creates a new bank journal export request.
.OUTPUTS
	The newly created bank journal export request.
#>
function New-BankJournalExportCounts {
	[CmdletBinding()]
	[OutputType([Mc2it.Agicap.TreasuryBankJournal.BankJournalExportCounts])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	[SuppressMessage("PSUseSingularNouns", "")]
	param (
		# The number of bank journal entries previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positive")]
		[int] $CurrentBankJournalEntriesCountInYear,

		# The number of bank journal previously created (starts at 1).
		[Parameter(Mandatory)]
		[ValidateRange("Positive")]
		[int] $CurrentBankJournalsCountInYear
	)

	return [BankJournalExportCounts]@{
		CurrentBankJournalEntriesCountInYear = $CurrentBankJournalEntriesCountInYear
		CurrentBankJournalsCountInYear = $CurrentBankJournalsCountInYear
	}
}
