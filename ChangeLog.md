# Changelog

## Version [0.3.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.2.0...v0.3.0)
- Added the `New-AgicapClient` cmdlet.
- Organizations: added the `Select-AgicapEntity` and `Select-AgicapOrganization` cmdlets.
- Payments: added the `New-AgicapBankAccount`, `New-AgicapBeneficiary` and `New-AgicapPostalAddress` cmdlets.
- Removed the `Get-AgicapApiUrl` cmdlet.

## Version [0.2.0](https://github.com/MC2IT/Agicap.ps1/compare/v0.1.1...v0.2.0)
- Added the `uriKind` parameter to the `Convert.ToUri()` method.
- Changed the type of `Instance` and `Type` properties from the `ProblemDetails` class to `Uri`.

## Version [0.1.1](https://github.com/MC2IT/Agicap.ps1/compare/v0.1.0...v0.1.1)
- Fixed the explicit conversion from a `PSObject` for the `PurchaseJournal.PurchaseJournal` and `TreasuryBankJournal.Counterpart` classes.

## Version 0.1.0
- Initial release: provides the `Get-AgicapApiUrl` and `Request-AgicapAccessToken` cmdlets.
