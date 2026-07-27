namespace Mc2it.Agicap.Organizations;

/// <summary>
/// Represents an entity within an organization.
/// </summary>
public class Entity {

	/// <summary>
	/// The ISO 3166 alpha-2 code of the country where the entity is located.
	/// </summary>
	public string Country { get; set; } = "";

	/// <summary>
	/// The entity identifier.
	/// </summary>
	public string Id { get; set; } = "";

	/// <summary>
	/// The entity name.
	/// </summary>
	public string Name { get; set; } = "";

	/// <summary>
	/// Creates a new entity from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The entity corresponding to the specified JSON payload.</returns>
	public static explicit operator Entity(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() {
			Country = Convert.ToString(json.country) ?? "",
			Id = Convert.ToString(json.id) ?? "",
			Name = Convert.ToString(json.name) ?? ""
		};
	}
}
