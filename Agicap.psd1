@{
	DefaultCommandPrefix = "Agicap"
	ModuleVersion = "0.9.0"
	PowerShellVersion = "7.6"
	RootModule = "Binaries/Mc2it.Agicap.PowerShell.dll"
	NestedModules = , "Sources/Main.psm1"

	Author = "MC2IT <dev@mc2it.com>"
	CompanyName = "MC2IT"
	Copyright = "© MC2IT"
	Description = "An Agicap API client library for PowerShell."
	GUID = "e6365c39-25a6-41c3-9300-e9b1e7d525c9"

	AliasesToExport = @()
	RequiredAssemblies = , "Binaries/Mc2it.Agicap.dll"
	VariablesToExport = @()

	CmdletsToExport = @(
		"New-NotImportedEntry"
		"New-NotImportedEntryError"
	)

	FunctionsToExport = @(
		"Approve-BankJournalEntry"
		"Close-Client"
		"Deny-AccountingPurchase"
		"Deny-BankJournalEntry"
		"Get-BankJournalExport"
		"Get-BeneficiarySynchronization"
		"New-AccountingAccount"
		"New-BankAccount"
		"New-BankJournalExportCounts"
		"New-Beneficiary"
		"New-Client"
		"New-Contact"
		"New-LegalAddress"
		"New-PostalAddress"
		"New-Supplier"
		"New-SynchronizedBeneficiary"
		"New-ThirdParty"
		"Remove-AccountingAccount"
		"Remove-Beneficiary"
		"Remove-ThirdParty"
		"Request-AccessToken"
		"Select-AccountingPurchase"
		"Select-BankJournalExport"
		"Select-Beneficiary"
		"Select-Entity"
		"Select-Organization"
		"Submit-AccountingAccount"
		"Submit-BankJournalExport"
		"Submit-Beneficiary"
		"Submit-ThirdParty"
		"Sync-Beneficiary"
		"Update-Beneficiary"
	)

	RequiredModules = @(
		@{ ModuleName = "Belin.FSharp"; ModuleVersion = "10.1.401" }
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/MC2IT/Agicap.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/MC2IT/Agicap.ps1"
			ReleaseNotes = "https://github.com/MC2IT/Agicap.ps1/releases"
			Tags = "accounting", "agicap", "api", "client", "sdk", "treasury"
		}
	}
}
