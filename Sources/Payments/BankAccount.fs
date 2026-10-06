namespace Mc2it.Agicap.Payments

open System.Management.Automation

/// Creates a new bank account.
[<Cmdlet(VerbsCommon.New, "BankAccount"); OutputType(typeof<BankAccount>)>]
type NewBankAccountCommand() =
  inherit Cmdlet()

  /// The name of the bank the account is located.
  [<Parameter(Position = 1)>]
  member val BankName = "" with get, set

  /// The ISO 3166 alpha-2 code of the country of the bank where the account is located.
  [<Parameter>]
  member val Country = "" with get, set

  /// The bank identifier code of the bank where the account is located.
  [<Parameter>]
  member val Bic = "" with get, set

  /// The bank account number (IBAN/BBAN/Other).
  [<Parameter>]
  member val Identifier = "" with get, set

  /// The bank identifier code of the intermediary bank processing the payments.
  [<Parameter>]
  member val IntermediaryBankBic = "" with get, set

  /// The local identifier of the bank.
  [<Parameter>]
  member val LocalClearingCode = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (BankAccount (
    BankName = (if this.BankName.Length > 0 then this.BankName else null),
    Bic = (if this.Bic.Length > 0 then this.Bic else null),
    Country = (if this.Country.Length > 0 then this.Country else null),
    Identifier = (if this.Identifier.Length > 0 then this.Identifier else null),
    IntermediaryBankBic = (if this.IntermediaryBankBic.Length > 0 then this.IntermediaryBankBic else null),
    LocalClearingCode = (if this.LocalClearingCode.Length > 0 then this.LocalClearingCode else null)
  ))
