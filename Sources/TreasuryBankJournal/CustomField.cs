namespace Mc2it.Agicap.TreasuryBankJournal;

/// <summary>
///	Represents a custom field.
/// </summary>
public class CustomField {

	/// <summary>
	/// The field name.
	/// </summary>
	public string Name { get; set; } = "";

	/// <summary>
	/// The field value.
	/// </summary>
	public string Value { get; set; } = "";

	/// <summary>
	/// Creates a new custom field from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The custom field corresponding to the specified JSON payload.</returns>
	public static explicit operator CustomField(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() {
			Name = Convert.ToString(json.name) ?? "",
			Value = Convert.ToString(json.value) ?? ""
		};
	}
}
