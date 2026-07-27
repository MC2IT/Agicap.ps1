namespace Mc2it.Agicap.TreasuryBankJournal;

/// <summary>
///	Provides information about the document associated with a counterpart.
/// </summary>
public class Document {

	/// <summary>
	/// The document issue date.
	/// </summary>
	public DateTime? DocumentIssueDate { get; set; }

	/// <summary>
	/// The document reference number.
	/// </summary>
	public string DocumentReference { get; set; } = "";

	/// <summary>
	/// The document type.
	/// </summary>
	public DocumentType DocumentType { get; set; } = DocumentType.OTHER;

	/// <summary>
	/// The external identifier of the owning entity in the source system.
	/// </summary>
	public string ExternalEntityId { get; set; } = "";

	/// <summary>
	/// The document identifier from the source system.
	/// </summary>
	public string ExternalId { get; set; } = "";

	/// <summary>
	/// The document due date.
	/// </summary>
	public DateTime OriginalDueDate { get; set; } = DateTime.MinValue;

	/// <summary>
	/// A unique alphanumeric identifier for the document.
	/// </summary>
	public string UniqueId { get; set; } = "";

	/// <summary>
	/// Creates a new document from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The document corresponding to the specified JSON payload.</returns>
	public static explicit operator Document(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() {
			DocumentIssueDate = Convert.ToDateTime(json.documentIssueDate),
			DocumentReference = Convert.ToString(json.documentReference) ?? "",
			DocumentType = Convert.ToEnum<DocumentType>(json.documentType) ?? DocumentType.OTHER,
			ExternalEntityId = Convert.ToString(json.externalEntityId) ?? "",
			ExternalId = Convert.ToString(json.externalId) ?? "",
			OriginalDueDate = Convert.ToDateTime(json.originalDueDate) ?? DateTime.MinValue,
			UniqueId = Convert.ToString(json.uniqueId) ?? ""
		};
	}
}
