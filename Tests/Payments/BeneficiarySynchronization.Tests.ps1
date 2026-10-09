<#
.SYNOPSIS
	Tests the features of the `Get-BeneficiarySynchronization` cmdlet.
#>
Describe "Get-BeneficiarySynchronization" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a beneficiary synchronization report" {
		$syncId = New-Guid "3c648676-e07e-4aca-8e63-ce0802221b57"

		$synchronization = Get-AgicapBeneficiarySynchronization $client -EntityId $entityId -SyncId $syncId
		$synchronization.CreatedAt.Date | Should-Be (Get-Date "2026-08-03T08:21:47.346206+00:00").Date
		$synchronization.Errors | Should-BeCollection -Count 1
		$synchronization.Status | Should-Be ([Mc2it.Agicap.Payments.BeneficiarySynchronizationStatus]::CompletedWithErrors)
		$synchronization.SyncId | Should-Be $syncId

		$syncError = $synchronization.Errors[0]
		$syncError.ErrorCode | Should-Be ([Mc2it.Agicap.Payments.BeneficiarySynchronizationErrorCode]::IncompletePostalAddress)
		$syncError.ErrorMessage | Should-BeLikeString "The synchronization failed*" -CaseSensitive
		$syncError.RowIndex | Should-Be 0
	}
}
