namespace Mc2it.Agicap.ChartOfAccounts

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Creates a new accounting account.
[<Cmdlet(VerbsCommon.New, "AccountingAccount"); OutputType(typeof<AccountingAccount>)>]
type NewAccountingAccount() =
  inherit Cmdlet()

  /// The accounting account number.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val AccountingAccountNumber = "" with get, set

  /// The accounting account name.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val AccountingAccountName = "" with get, set

  /// The accounting account type.
  [<Parameter>]
  member val AccountingAccountType = Nullable<AccountingAccountType>() with get, set

  /// An optional ERP-specific external identifier.
  [<Parameter>]
  member val ExternalId = "" with get, set

  /// The tax key.
  [<Parameter>]
  member val TaxKey = "" with get, set

  /// The VAT rate.
  [<Parameter>]
  member val VatRate = Nullable<double>() with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (AccountingAccount (
    AccountingAccountName = this.AccountingAccountName,
    AccountingAccountNumber = this.AccountingAccountNumber,
    AccountingAccountType = this.AccountingAccountType,
    ExternalId = (if this.ExternalId.Length > 0 then this.ExternalId else null),
    TaxKey = (if this.TaxKey.Length > 0 then this.TaxKey else null),
    VatRate = this.VatRate
  ))

/// Deletes the accounting accounts with the specified numbers.
[<Cmdlet(VerbsCommon.Remove, "AccountingAccount", DefaultParameterSetName = "InputObject"); OutputType(typeof<Void>)>]
type RemoveAccountingAccount() =
  inherit PSCmdlet()

  /// Manages the accounting accounts of the chart of accounts.
  let mutable api: AccountingAccountApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The accounting accounts to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline = true)>]
  member val InputObject: AccountingAccount array = [||] with get, set

  /// The numbers of accounting accounts to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "AccountingAccountNumber", Position = 3)>]
  member val AccountingAccountNumber: string array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).ChartOfAccounts.AccountingAccounts this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try
      match this.ParameterSetName with
      | "AccountingAccountNumber" -> client.Delete this.AccountingAccountNumber
      | _ -> client.Delete this.InputObject
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "AccountingAccountApi.Delete", ErrorCategory.WriteError, client))

/// Creates new accounting accounts.
/// Returns metrics about the import of accounting accounts.
[<Cmdlet(VerbsLifecycle.Submit, "AccountingAccount"); OutputType(typeof<ImportResponse>)>]
type SubmitAccountingAccount() =
  inherit Cmdlet()

  /// Manages the accounting accounts of the chart of accounts.
  let mutable api: AccountingAccountApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The accounting accounts to create.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: AccountingAccount array = [||] with get, set

  /// The identifier to assign to the import.
  [<Parameter>]
  member val ImportId = Guid.CreateVersion7() with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).ChartOfAccounts.AccountingAccounts this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Create(this.InputObject, this.ImportId))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "AccountingAccountApi.Create", ErrorCategory.WriteError, client))
