namespace Mc2it.Agicap.Authentication;

/// <summary>
///	Represents a bad request.
/// </summary>
public sealed class BadRequest {

	/// <summary>
	/// The error message.
	/// </summary>
	public string Error { get; set; } = "";

	/// <summary>
	/// Creates a new bad request from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The bad request corresponding to the specified JSON payload.</returns>
	public static explicit operator BadRequest(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() { Error = Convert.ToString(json.error) ?? "" };
	}
}
