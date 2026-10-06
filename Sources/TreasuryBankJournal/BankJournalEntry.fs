namespace Mc2it.Agicap.TreasuryBankJournal

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Notifies Agicap that the specified bank journal entries were successfully imported in the client accounting system.
[<Cmdlet(VerbsLifecycle.Approve, "BankJournalEntry", DefaultParameterSetName = "InputObject"); OutputType(typeof<Void>)>]
type ApproveBankJournalEntryCommand() =
  inherit PSCmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: ExportApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The bank journal entries to mark as imported.
  [<Parameter(Mandatory = true, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline = true)>]
  member val InputObject: ImportedEntry array = [||] with get, set

  /// The identifiers of bank journal entries to mark as imported.
  [<Parameter(Mandatory = true, ParameterSetName = "EntryAgicapUniqueId", Position = 3)>]
  member val EntryAgicapUniqueId: Guid array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).TreasuryBankJournal.Exports this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try
      match this.ParameterSetName with
      | "EntryAgicapUniqueId" -> client.MarkAsImported this.EntryAgicapUniqueId
      | _ -> client.MarkAsImported this.InputObject
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "ExportApi.MarkAsImported", ErrorCategory.WriteError, client))

/// Notifies Agicap that the specified bank journal entries were not correctly imported in the client accounting system.
[<Cmdlet(VerbsLifecycle.Deny, "BankJournalEntry"); OutputType(typeof<Void>)>]
type DenyBankJournalEntryCommand() =
  inherit Cmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: ExportApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The bank journal entries to mark as not imported.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: NotImportedEntry array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).TreasuryBankJournal.Exports this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try client.MarkAsNotImported this.InputObject
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "EntityApi.MarkAsNotImported", ErrorCategory.WriteError, client))
