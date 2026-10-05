namespace Mc2it.Agicap.ChartOfAccounts

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Creates a new third-party.
[<Cmdlet(VerbsCommon.New, "ThirdParty"); OutputType(typeof<ThirdParty>)>]
type NewThirdPartyCommand() =
  inherit Cmdlet()

  /// The code of the third-party.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val ThirdPartyCode = "" with get, set

  /// The name of the third-party.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val ThirdPartyName = "" with get, set

  /// The accounting account number.
  [<Parameter(Mandatory = true)>]
  member val AccountingAccountNumber = "" with get, set

  /// An optional ERP-specific external identifier.
  [<Parameter>]
  member val ExternalId = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (ThirdParty (
    AccountingAccountNumber = this.AccountingAccountNumber,
    ExternalId = (if this.ExternalId.Length > 0 then this.ExternalId else null),
    ThirdPartyCode = this.ThirdPartyCode,
    ThirdPartyName = this.ThirdPartyName
  ))

/// Deletes the third-parties with the specified codes.
[<Cmdlet(VerbsCommon.Remove, "ThirdParty", DefaultParameterSetName = "InputObject"); OutputType(typeof<Void>)>]
type RemoveThirdPartyCommand() =
  inherit PSCmdlet()

  /// Manages the third-parties of the chart of accounts.
  let mutable api: ThirdPartyApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The third-parties to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline = true)>]
  member val InputObject: ThirdParty array = [||] with get, set

  /// The codes of third-parties to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "ThirdPartyCode", Position = 3)>]
  member val ThirdPartyCode: string array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).ChartOfAccounts.ThirdParties this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try
      match this.ParameterSetName with
      | "ThirdPartyCode" -> client.Delete this.ThirdPartyCode
      | _ -> client.Delete this.InputObject
    with :? HttpRequestException as ex -> this.WriteError (ErrorRecord(ex, "ThirdPartyApi.Delete", ErrorCategory.WriteError, client))

/// Creates new third-parties.
/// Returns metrics about the import of third-parties.
[<Cmdlet(VerbsLifecycle.Submit, "ThirdParty"); OutputType(typeof<ImportResponse>)>]
type SubmitThirdPartyCommand() =
  inherit Cmdlet()

  /// Manages the third-parties of the chart of accounts.
  let mutable api: ThirdPartyApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The third-parties to create.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: ThirdParty array = [||] with get, set

  /// The identifier to assign to the import.
  [<Parameter>]
  member val ImportId = Guid.CreateVersion7() with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).ChartOfAccounts.ThirdParties this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Create(this.InputObject, this.ImportId))
    with :? HttpRequestException as ex -> this.WriteError (ErrorRecord(ex, "ThirdPartyApi.Create", ErrorCategory.WriteError, client))
