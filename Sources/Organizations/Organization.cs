namespace Mc2it.Agicap.Organizations;

/// <summary>
/// Represents an organization.
/// </summary>
public class Organization {

	/// <summary>
	/// The organization identifier.
	/// </summary>
	public string Id { get; set; } = "";

	/// <summary>
	/// The organization name.
	/// </summary>
	public string Name { get; set; } = "";

	/// <summary>
	/// Creates a new organization from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The organization corresponding to the specified JSON payload.</returns>
	public static explicit operator Organization(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() {
			Id = Convert.ToString(json.id) ?? "",
			Name = Convert.ToString(json.name) ?? ""
		};
	}
}
