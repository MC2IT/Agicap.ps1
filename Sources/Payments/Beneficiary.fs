namespace Mc2it.Agicap.Payments

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Creates a new beneficiary.
[<Cmdlet(VerbsCommon.New, "Beneficiary"); OutputType(typeof<Beneficiary>)>]
type NewBeneficiaryCommand() =
  inherit Cmdlet()

  /// The name of the beneficiary.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Name = "" with get, set

  /// The bank account of the beneficiary.
  [<Parameter>]
  member val BankAccount: BankAccount | null = null with get, set

  /// The postal address of the beneficiary.
  [<Parameter>]
  member val PostalAddress: PostalAddress | null = null with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Beneficiary (
    BankAccount = this.BankAccount,
    Name = this.Name,
    PostalAddress = this.PostalAddress
  ))

/// Deletes either the specified beneficiary, or all beneficiaries.
[<Cmdlet(VerbsCommon.Remove, "Beneficiary", DefaultParameterSetName = "InputObject"); OutputType(typeof<Void>)>]
type RemoveBeneficiaryCommand() =
  inherit PSCmdlet()

  /// Manages the beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiaryApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The beneficiary to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "InputObject", Position = 3, ValueFromPipeline = true)>]
  member val InputObject: Beneficiary | null = null with get, set

  /// The identifier of the beneficiary to delete.
  [<Parameter(Mandatory = true, ParameterSetName = "BeneficiaryId", Position = 3)>]
  member val BeneficiaryId = Guid.Empty with get, set

  /// Value indicating whether to delete all beneficiaries.
  [<Parameter(ParameterSetName = "All")>]
  member val All = SwitchParameter false with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try
      match this.ParameterSetName with
      | "All" -> client.DeleteAll()
      | "BeneficiaryId" -> client.Delete this.BeneficiaryId
      | _ -> client.Delete (nonNull this.InputObject)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiaryApi.Delete", ErrorCategory.WriteError, client))

/// Fetches the beneficiaries of the entity with the specified identifier.
[<Cmdlet(VerbsCommon.Select, "Beneficiary"); OutputType(typeof<Beneficiary>)>]
type SelectBeneficiaryCommand() =
  inherit Cmdlet()

  /// Manages the beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiaryApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.ReadAll())
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiaryApi.ReadAll", ErrorCategory.ReadError, client))

/// Creates a new beneficiary.
/// Returns the identifier of the newly created beneficiary.
[<Cmdlet(VerbsLifecycle.Submit, "Beneficiary"); OutputType(typeof<Guid>)>]
type SubmitBeneficiaryCommand() =
  inherit Cmdlet()

  /// Manages the beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiaryApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The beneficiary to create.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: Beneficiary | null = null with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Create (nonNull this.InputObject))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiaryApi.Create", ErrorCategory.ReadError, client))

/// Starts a bulk synchronization of beneficiaries from the ERP software.
/// Returns the identifier of the newly started synchronization.
[<Cmdlet(VerbsData.Sync, "Beneficiary"); OutputType(typeof<Guid>)>]
type SyncBeneficiaryCommand() =
  inherit Cmdlet()

  /// Manages the sychronization of beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiarySynchronizationApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The beneficiaries to synchronize.
  [<Parameter(Mandatory = true, Position = 3)>]
  member val Beneficiary: SynchronizedBeneficiary array = [||] with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries(this.EntityId).Synchronization

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.Create this.Beneficiary)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiarySynchronizationApi.Create", ErrorCategory.WriteError, client))

/// Updates the specified beneficiary.
[<Cmdlet(VerbsData.Update, "Beneficiary"); OutputType(typeof<Void>)>]
type UpdateBeneficiaryCommand() =
  inherit Cmdlet()

  /// Manages the beneficiaries of the entity with the specified identifier.
  let mutable api: BeneficiaryApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The entity identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val EntityId = 0 with get, set

  /// The beneficiary to update.
  [<Parameter(Mandatory = true, Position = 3, ValueFromPipeline = true)>]
  member val InputObject: Beneficiary | null = null with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Payments.Beneficiaries this.EntityId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try client.Update (nonNull this.InputObject)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "BeneficiaryApi.Update", ErrorCategory.WriteError, client))
