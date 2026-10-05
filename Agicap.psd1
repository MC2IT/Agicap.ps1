@{
	DefaultCommandPrefix = "Agicap"
	ModuleVersion = "0.9.0"
	PowerShellVersion = "7.6"
	RootModule = "Binaries/Mc2it.Agicap.PowerShell.dll"

	Author = "MC2IT <dev@mc2it.com>"
	CompanyName = "MC2IT"
	Copyright = "© MC2IT"
	Description = "An Agicap API client library for PowerShell."
	GUID = "e6365c39-25a6-41c3-9300-e9b1e7d525c9"

	AliasesToExport = @()
	NestedModules = , "Sources/Main.psm1"
	RequiredAssemblies = , "Binaries/Mc2it.Agicap.dll"
	VariablesToExport = @()

	CmdletsToExport = @(
		"New-AccountingAccount"
		"New-NotImportedEntry"
		"New-NotImportedEntryError"
		"New-ThirdParty"
		"Remove-AccountingAccount"
		"Remove-ThirdParty"
		"Request-AccessToken"
		"Select-Entity"
		"Select-Organization"
		"Submit-AccountingAccount"
		"Submit-ThirdParty"
	)

	FunctionsToExport = @(
		"Approve-BankJournalEntry"
		"Close-Client"
		"Deny-AccountingPurchase"
		"Deny-BankJournalEntry"
		"Get-BankJournalExport"
		"Get-BeneficiarySynchronization"
		"New-BankAccount"
		"New-BankJournalExportCounts"
		"New-Beneficiary"
		"New-Client"
		"New-Contact"
		"New-LegalAddress"
		"New-PostalAddress"
		"New-Supplier"
		"New-SynchronizedBeneficiary"
		"Remove-Beneficiary"
		"Select-AccountingPurchase"
		"Select-BankJournalExport"
		"Select-Beneficiary"
		"Submit-BankJournalExport"
		"Submit-Beneficiary"
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
