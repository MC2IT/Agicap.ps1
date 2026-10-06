namespace Mc2it.Agicap.Payments

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Fetches the synchronization report with the specified identifier.
[<Cmdlet(VerbsCommon.Get, "BeneficiarySynchronization"); OutputType(typeof<BeneficiarySynchronization>)>]
type GetBeneficiarySynchronizationCommand() =
  inherit Cmdlet()

  /// Manages the sychronization of beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiarySynchronizationApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The identifier of the synchronization report.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val SyncId = Guid.Empty with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries(this.EntityId).Synchronization

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Read this.SyncId)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiarySynchronizationApi.Read", ErrorCategory.ReadError, client))
