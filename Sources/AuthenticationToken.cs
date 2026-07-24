namespace Mc2it.Agicap;

using Microsoft.PowerShell.Commands;
using System.Security;

/// <summary>
///	Represents an OAuth token and its metadata.
/// </summary>
public sealed class AuthenticationToken {

	/// <summary>
	/// The time when the provided token expires.
	/// </summary>
	public DateTime ExpiresOn { get; init; } = DateTime.Now;

	/// <summary>
	/// Value indicating whether this token has expired.
	/// </summary>
	public bool HasExpired => ExpiresOn <= DateTime.Now;

	/// <summary>
	/// The OAuth scopes.
	/// </summary>
	public IList<string> Scopes { get; init; } = [];

	/// <summary>
	/// The token type.
	/// </summary>
	public WebAuthenticationType Type { get; init; } = WebAuthenticationType.Bearer;

	/// <summary>
	/// The token value.
	/// </summary>
	public SecureString Value { get; init; } = new();

	/// <summary>
	/// Creates a new access token from the specified JSON entity.
	/// </summary>
	/// <param name="psObject">The JSON entity.</param>
	/// <returns>The access token corresponding to the specified JSON entity.</returns>
	public static explicit operator AuthenticationToken(PSObject psObject) {
		var json = (dynamic) psObject;

		var secureString = new SecureString();
		if (json.access_token is string accessToken) {
			Array.ForEach(accessToken.ToCharArray(), secureString.AppendChar);
			secureString.MakeReadOnly();
		}

		return new AuthenticationToken() {
			ExpiresOn = DateTime.Now.AddSeconds(json.expires_in is int expiresIn ? expiresIn : 0),
			Scopes = json.scope is string scope ? [.. scope.Split(' ')] : new List<string>(),
			Type = json.token_type is string tokenType ? Enum.Parse<WebAuthenticationType>(tokenType, ignoreCase: true) : WebAuthenticationType.Bearer,
			Value = secureString
		};
	}
}
