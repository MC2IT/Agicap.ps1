<#
.SYNOPSIS
	Tests the features of the `Get-BeneficiarySynchronization` cmdlet.
#>
Describe "Get-BeneficiarySynchronization" -Skip:($Env:CI -eq "true") {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a beneficiary synchronization report" {
		$syncId = "3c648676-e07e-4aca-8e63-ce0802221b57" | New-Guid

		$synchronization = Get-AgicapBeneficiarySynchronization $client $entityId $syncId
		Should-Be (Get-Date "2026-08-03T08:21:47.346206+00:00").Date $synchronization.CreatedAt.Date
		Should-BeCollection $synchronization.Errors -Count 1
		Should-Be ([Mc2it.Agicap.Payments.BeneficiarySynchronizationStatus]::CompletedWithErrors) $synchronization.Status
		Should-Be $syncId $synchronization.SyncId

		$syncError = $synchronization.Errors[0]
		Should-Be ([Mc2it.Agicap.Payments.BeneficiarySynchronizationErrorCode]::IncompletePostalAddress) $syncError.ErrorCode
		Should-BeLikeString "The synchronization failed*" $syncError.ErrorMessage -CaseSensitive
		Should-Be 0 $syncError.RowIndex
	}
}
