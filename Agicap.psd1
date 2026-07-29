@{
	DefaultCommandPrefix = "Agicap"
	ModuleVersion = "0.3.0"
	PowerShellVersion = "7.6"
	RootModule = "Sources/Main.psm1"

	Author = "MC2IT <dev@mc2it.com>"
	CompanyName = "MC2IT"
	Copyright = "© MC2IT"
	Description = "An Agicap API client library for PowerShell."
	GUID = "e6365c39-25a6-41c3-9300-e9b1e7d525c9"

	AliasesToExport = @()
	CmdletsToExport = @()
	RequiredAssemblies = , "Binaries/Mc2it.Agicap.dll"
	VariablesToExport = @()

	FunctionsToExport = @(
		"New-BankAccount"
		"New-Beneficiary"
		"New-Client"
		"New-PostalAddress"
		"Request-AccessToken"
		"Select-Beneficiary"
		"Select-Entity"
		"Select-Organization"
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
