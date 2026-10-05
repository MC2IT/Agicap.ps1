namespace Mc2it.Agicap.Organizations

open Mc2it.Agicap
open System
open System.Management.Automation
open System.Net.Http

/// Fetches the entities of the organization with the specified identifier.
[<Cmdlet(VerbsCommon.Select, "Entity"); OutputType(typeof<PaginatedList<Entity>>)>]
type SelectEntityCommand() =
  inherit Cmdlet()

  /// Manages the entities of the organization with the specified identifier.
  let mutable api: EntityApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The organization identifier.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val OrganizationId = Guid.Empty with get, set

  /// The page number.
  [<Parameter; ValidateRange(ValidateRangeKind.Positive)>]
  member val PageNumber = 1 with get, set

  /// The number of elements per page.
  [<Parameter; ValidateRange(2, 100)>]
  member val PageSize = 100 with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Organizations.Entities this.OrganizationId

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.ReadAll(this.PageNumber, this.PageSize))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "EntityApi.ReadAll", ErrorCategory.ReadError, client))
