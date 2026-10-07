namespace Mc2it.Agicap

open Mc2it.Agicap.Authentication
open System
open System.Management.Automation

/// Releases the resources associated with the specified client.
[<Cmdlet(VerbsCommon.Close, "Client"); OutputType(typeof<Void>)>]
type CloseClient() =
  inherit Cmdlet()

  /// The Free Mobile client to dispose.
  [<Parameter(Mandatory = true, Position = 1, ValueFromPipeline = true)>]
  member val InputObject: Client | null = null with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = (nonNull this.InputObject).Dispose()

/// Creates a new Agicap API client.
[<Cmdlet(VerbsCommon.New, "Client"); OutputType(typeof<Client>)>]
type NewClient() =
  inherit Cmdlet()

  /// The assembly version.
  static let version = SemanticVersion (typeof<NewClient>.Assembly.GetName().Version)

  /// The client identifier and secret.
  [<Parameter(Mandatory = true, Position = 1, ValueFromPipeline = true); Credential>]
  member val Credential: PSCredential | null = null with get, set

  /// The scopes to use by default when invoking the `Request-AccessToken` cmdlet.
  [<Parameter; ValidateNotNullOrEmpty>]
  member val Scope: string array = [| Scopes.PublicApi |] with get, set

  /// The user agent string to use when making requests.
  [<Parameter; ValidateNotNullOrWhiteSpace>]
  member val UserAgent = $"PowerShell/{PSVersionInfo.PSVersion} | Mc2it.Agicap/{version}" with get, set

  /// The base URL of the remote API endpoint.
  [<Parameter; ValidateNotNull>]
  member val Uri = Uri "https://api.agicap.com/public/" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (new Client(
    (nonNull this.Credential).GetNetworkCredential(),
    BaseUrl = this.Uri,
    DefaultScopes = this.Scope,
    UserAgent = this.UserAgent
  ))
