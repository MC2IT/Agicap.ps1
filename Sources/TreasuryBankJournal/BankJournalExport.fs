namespace Mc2it.Agicap.TreasuryBankJournal

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Fetches the bank journal export with the specified identifier.
[<Cmdlet(VerbsCommon.Get, "BankJournalExport"); OutputType(typeof<BankJournalExport>)>]
type GetBankJournalExportCommand() =
  inherit Cmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: ExportApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The identifier of the bank journal export.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val ExportId = Guid.Empty with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).TreasuryBankJournal.Exports this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Read this.ExportId)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "ExportApi.Read", ErrorCategory.ReadError, client))

/// Creates a new bank journal export request.
[<Cmdlet(VerbsCommon.New, "BankJournalExportCounts"); OutputType(typeof<BankJournalExportCounts>)>]
type NewBankJournalExportCountsCommand() =
  inherit Cmdlet()

  /// The number of bank journal entries previously created (starts at 1).
  [<Parameter(Mandatory = true); ValidateRange(ValidateRangeKind.Positive)>]
  member val CurrentBankJournalEntriesCountInYear = 0 with get, set

  /// The number of bank journal previously created (starts at 1).
  [<Parameter(Mandatory = true); ValidateRange(ValidateRangeKind.Positive)>]
  member val CurrentBankJournalsCountInYear = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (BankJournalExportCounts (
    CurrentBankJournalEntriesCountInYear = this.CurrentBankJournalEntriesCountInYear,
    CurrentBankJournalsCountInYear = this.CurrentBankJournalsCountInYear
  ))

/// Fetches the exports of the treasury bank journal.
[<Cmdlet(VerbsCommon.Select, "BankJournalExport"); OutputType(typeof<CursorPaginatedList<BankJournalExportSummary>>)>]
type SelectBankJournalExportCommand() =
  inherit PSCmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: ExportApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The number of bank journal entries to fetch.
  [<Parameter; ValidateRange(ValidateRangeKind.Positive)>]
  member val Size = 100 with get, set

  /// The export start date.
  [<Parameter(ParameterSetName = "After")>]
  member val After = Nullable<DateTime>() with get, set

  /// The export end date.
  [<Parameter(ParameterSetName = "Before")>]
  member val Before = Nullable<DateTime>() with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).TreasuryBankJournal.Exports this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.ReadAll(this.Size, this.After, this.Before))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "ExportApi.ReadAll", ErrorCategory.ReadError, client))

/// Exports all bank journal entries ready to be exported.
[<Cmdlet(VerbsLifecycle.Submit, "BankJournalExport"); OutputType(typeof<BankJournalExport>)>]
type SubmitBankJournalExportCommand() =
  inherit Cmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: ExportApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The identifier to assign to the export.
  [<Parameter>]
  member val ExportId = Guid.CreateVersion7() with get, set

  /// Optional export parameters allowing to set where to start.
  [<Parameter>]
  member val CurrentExportCounts: BankJournalExportCounts | null = null with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).TreasuryBankJournal.Exports this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Create(this.ExportId, this.CurrentExportCounts))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "ExportApi.Create", ErrorCategory.WriteError, client))
