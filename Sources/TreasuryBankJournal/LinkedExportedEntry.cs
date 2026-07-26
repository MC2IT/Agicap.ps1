namespace Mc2it.Agicap.TreasuryBankJournal;

/// <summary>
///	Represents a reference to a previously exported journal entry linked to a counterpart.
/// </summary>
public class LinkedExportedEntry {

	/// <summary>
	/// The unique identifier of the linked entry.
	/// </summary>
	public Guid AgicapUniqueId { get; set; } = Guid.Empty;

	/// <summary>
	/// The unique export reference of the linked entry.
	/// </summary>
	public string ExportEntryReference { get; set; } = "";

	/// <summary>
	/// Creates a new linked entry from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The linked entry corresponding to the specified JSON payload.</returns>
	public static explicit operator LinkedExportedEntry(PSObject psObject) {
		var json = (dynamic) psObject;
		return new LinkedExportedEntry() {
			AgicapUniqueId = Convert.ToGuid(json.agicapUniqueId) ?? Guid.Empty,
			ExportEntryReference = Convert.ToString(json.exportEntryReference) ?? ""
		};
	}
}
