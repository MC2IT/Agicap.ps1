# Changelog

## Version [0.6.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.5.1...v0.6.0)
- **Chart of accounts:** added the `New-AccountingAccount`, `Remove-AccountingAccount`, `Submit-AccountingAccount`, `New-ThirdParty`, `Remove-ThirdParty` and `Submit-ThirdParty` cmdlets.
- **Organizations:** removed the `-All` parameter from the `Select-Entity` and `Select-Organization` cmdlets.
- **Payments:** removed the `-Wait` parameter from the `Sync-Beneficiary` cmdlet.

## Version [0.5.1](https://github.com/MC2IT/Agicap.ps1/compare/v0.5.0...v0.5.1)
- **Payments:** allows empty strings for mandatory parameters of the `New-PostalAddress` cmdlet.

## Version [0.5.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.4.0...v0.5.0)
- **Payments:** added the `Get-BeneficiarySynchronization`, `New-SynchronizedBeneficiary` and `Sync-Beneficiary` cmdlets.

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
