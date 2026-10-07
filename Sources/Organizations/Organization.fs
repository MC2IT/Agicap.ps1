namespace Mc2it.Agicap.Organizations

open Mc2it.Agicap
open System.Management.Automation
open System.Net.Http

/// Fetches the organization list.
[<Cmdlet(VerbsCommon.Select, "Organization"); OutputType(typeof<PaginatedList<Organization>>)>]
type SelectOrganization() =
  inherit Cmdlet()

  /// Manages the organizations.
  let mutable api: OrganizationApi | null = null

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The page number.
  [<Parameter; ValidateRange(ValidateRangeKind.Positive)>]
  member val PageNumber = 1 with get, set

  /// The number of elements per page.
  [<Parameter; ValidateRange(2, 100)>]
  member val PageSize = 100 with get, set

  /// Performs initialization of command execution.
  override this.BeginProcessing () =
    api <- (nonNull this.Client).Organizations

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull api
    try this.WriteObject (client.ReadAll(this.PageNumber, this.PageSize))
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "OrganizationApi.ReadAll", ErrorCategory.ReadError, client))
