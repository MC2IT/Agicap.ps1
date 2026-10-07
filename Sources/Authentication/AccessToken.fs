namespace Mc2it.Agicap.Authentication

open Mc2it.Agicap
open System.Management.Automation
open System.Net.Http

/// Requests a new access token.
[<Cmdlet(VerbsLifecycle.Request, "AccessToken"); OutputType(typeof<AccessToken>)>]
type RequestAccessToken() =
  inherit Cmdlet()

  /// The API client.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Client: Client | null = null with get, set

  /// The delegated permissions to consent to.
  [<Parameter(Position = 2); ValidateNotNull>]
  member val Scope: string array = [||] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let client = nonNull this.Client
    try this.WriteObject (client.Authenticate this.Scope)
    with :? HttpRequestException as ex ->
      this.WriteError (ErrorRecord(ex, "Client.Authenticate", ErrorCategory.AuthenticationError, client))
