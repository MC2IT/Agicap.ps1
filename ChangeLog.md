# Changelog

## Version [0.5.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.4.0...v0.5.0)
- **Payments:** added the `New-SynchronizedBeneficiary`, `Sync-Beneficiary` cmdlets.

## Version [0.4.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.3.0...v0.4.0)
- Added the `-Scope` parameter to the `New-Client` cmdlet.
- **Payments:** added the `Remove-Beneficiary`, `Select-Beneficiary`, `Submit-Beneficiary` and `Update-Beneficiary` cmdlets.

## Version [0.3.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.2.0...v0.3.0)
- Added the `New-Client` cmdlet.
- Removed the `Get-ApiUrl` cmdlet.
- **Organizations:** added the `Select-Entity` and `Select-Organization` cmdlets.
- **Payments:** added the `New-BankAccount`, `New-Beneficiary` and `New-PostalAddress` cmdlets.

## Version [0.2.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.1.1...v0.2.0)
- Added the `uriKind` parameter to the `Convert.ToUri()` method.
- Changed the type of `Instance` and `Type` properties from the `ProblemDetails` class to `Uri`.

## Version [0.1.1](https://github.com/MC2IT/Agicap.ps1/compare/v0.1.0...v0.1.1)
- Fixed the explicit conversion from a `PSObject` for the `PurchaseJournal.PurchaseJournal` and `TreasuryBankJournal.Counterpart` classes.

## Version 0.1.0
- Initial release: provides the `Get-ApiUrl` and `Request-AccessToken` cmdlets.
