namespace Mc2it.Agicap.PurchaseJournal

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Notifies Agicap that the specified purchase journal entries were not correctly imported in the client accounting system.
[<Cmdlet(VerbsLifecycle.Deny, "AccountingPurchase"); OutputType(typeof<Void>)>]
type DenyAccountingPurchaseCommand() =
  inherit Cmdlet()

  /// Manages the purchase journal.
  let mutable api: AccountingPurchaseApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The purchase journal entry to mark as not imported.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: NotImportedEntry array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).PurchaseJournal.AccountingPurchases this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try client.MarkAsNotImported this.InputObject
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "AccountingPurchaseApi.MarkAsNotImported", ErrorCategory.WriteError, client))

/// Fetches the entries of the purchase journal.
[<Cmdlet(VerbsCommon.Select, "AccountingPurchase"); OutputType(typeof<PaginatedList<PurchaseJournalEntry>>)>]
type SelectAccountingPurchaseCommand() =
  inherit Cmdlet()

  /// Manages the purchase journal.
  let mutable api: AccountingPurchaseApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The date of the last synchronization.
  [<Parameter(Mandatory = true, Position = 3)>]
  member val LastSynchronizationDate = Nullable<DateTime>() with get, set

  /// The page number.
  [<Parameter; ValidateRange(ValidateRangeKind.Positive)>]
  member val PageNumber = 1 with get, set

  /// The number of elements per page.
  [<Parameter; ValidateRange(2, 100)>]
  member val PageSize = 100 with get, set

  /// An opt-in enrichment selector.
  [<Parameter>]
  member val Include = "" with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).PurchaseJournal.AccountingPurchases this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try
      let enrichment = if this.Include.Length > 0 then withNull this.Include else null
      this.WriteObject (client.ReadAll(this.LastSynchronizationDate, this.PageNumber, this.PageSize, enrichment))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "AccountingPurchaseApi.ReadAll", ErrorCategory.ReadError, client))
