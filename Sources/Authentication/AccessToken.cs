namespace Mc2it.Agicap.Authentication;

using Microsoft.PowerShell.Commands;
using System.Security;

/// <summary>
///	Represents an OAuth token and its metadata.
/// </summary>
public sealed class AccessToken {

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
	/// Creates a new access token from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The access token corresponding to the specified JSON payload.</returns>
	public static explicit operator AccessToken(PSObject psObject) {
		var json = (dynamic) psObject;

		var secureString = new SecureString();
		if (json.access_token is string accessToken) Array.ForEach(accessToken.ToCharArray(), secureString.AppendChar);
		secureString.MakeReadOnly();

		return new AccessToken() {
			ExpiresOn = DateTime.Now.AddSeconds(Convert.ToInt32(json.expires_in) ?? 0),
			Scopes = json.scope is string scope && scope.Length > 0 ? [.. scope.Split(' ')] : new List<string>(),
			Type = Convert.ToEnum<WebAuthenticationType>(json.token_type) ?? WebAuthenticationType.Bearer,
			Value = secureString
		};
	}
}
