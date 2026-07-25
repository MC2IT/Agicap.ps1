namespace Mc2it.Agicap.PurchaseJournal;

/// <summary>
/// Represents an entry of the Agicap purchase journal.
/// </summary>
public class PurchaseJournal {

	/// <summary>
	/// The purchase journals.
	/// </summary>
	public IList<AccountingLine> AccountingLines { get; set; } = [];

	/// <summary>
	/// A unique identifier from Agicap.
	/// </summary>
	public Guid AgicapUniqueId = Guid.Empty;

	/// <summary>
	/// The billing date of the document.
	/// </summary>
	public DateTime BillingDate { get; set; }

	/// <summary>
	/// The date when the payment is due.
	/// </summary>
	public DateTime? DueDate { get; set; }

	/// <summary>
	/// The reference number of the document.
	/// </summary>
	public string InvoiceOrReceiptNumber { get; set; } = "";

	/// <summary>
	/// The description manually entered.
	/// </summary>
	public string Note { get; set; } = "";

	/// <summary>
	/// The number(s) of the purchase order(s).
	/// </summary>
	public IList<string> OrderNumbers { get; set; } = [];

	/// <summary>
	/// The extension of the original file.
	/// </summary>
	public string OriginalFileExtension { get; set; } = "";

	/// <summary>
	/// The URL of the original file.
	/// </summary>
	public Uri? OriginalFileUrl { get; set; }

	/// <summary>
	/// The payment method.
	/// </summary>
	public PaymentMethod PaymentMethod { get; set; } = PaymentMethod.None;

	/// <summary>
	/// The date when the service occurred.
	/// </summary>
	public DateTime? PerformanceDate { get; set; }

	/// <summary>
	/// The end date if time frame provided.
	/// </summary>
	public DateTime? PrepaidExpenseEndDate { get; set; }

	/// <summary>
	/// The start date if time frame provided.
	/// </summary>
	public DateTime? PrepaidExpenseStartDate { get; set; }

	/// <summary>
	/// The name of the supplier.
	/// </summary>
	public string SupplierOrMerchant { get; set; } = "";

	/// <summary>
	/// The title manually entered.
	/// </summary>
	public string Title { get; set; } = "";

	/// <summary>
	/// The type of the source document.
	/// </summary>
	public Typology Typology { get; set; } = Typology.OwedInvoice;

	/// <summary>
	/// A unique identifier.
	/// </summary>
	public string UniqueId { get; set; } = "";

	/// <summary>
	/// Creates a new purchase journal from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The purchase journal corresponding to the specified JSON payload.</returns>
	public static explicit operator PurchaseJournal(PSObject psObject) {
		var json = (dynamic) psObject;
		return new PurchaseJournal() {
			AccountingLines = Convert.ToList<AccountingLine>(json.accountingLines),
			AgicapUniqueId = json.agicapUniqueId is string agicapUniqueId ? Guid.Parse(agicapUniqueId) : Guid.Empty,
			BillingDate = json.billingDate is string billingDate ? DateTime.Parse(billingDate) : DateTime.MinValue,
			DueDate = json.dueDate is string dueDate ? DateTime.Parse(dueDate) : null,
			InvoiceOrReceiptNumber = json.invoiceOrReceiptNumber as string ?? "",
			Note = json.note as string ?? "",
			OrderNumbers = Convert.ToList<string>(json.orderNumbers),
			OriginalFileExtension = json.originalFileExtension as string ?? "",
			OriginalFileUrl = json.originalFileUrl is string originalFileUrl ? new Uri(originalFileUrl, UriKind.Absolute) : null,
			PaymentMethod = Convert.ToEnum<PaymentMethod>(json.accountType, PaymentMethod.None),
			PerformanceDate = json.performanceDate is string performanceDate ? DateTime.Parse(performanceDate) : null,
			PrepaidExpenseEndDate = json.prepaidExpenseEndDate is string prepaidExpenseEndDate ? DateTime.Parse(prepaidExpenseEndDate) : null,
			PrepaidExpenseStartDate = json.prepaidExpenseStartDate is string prepaidExpenseStartDate ? DateTime.Parse(prepaidExpenseStartDate) : null,
			SupplierOrMerchant = json.supplierOrMerchant as string ?? "",
			Title = json.title as string ?? "",
			Typology = Convert.ToEnum<Typology>(json.accountType, Typology.OwedInvoice),
			UniqueId = json.uniqueId as string ?? ""
		};
	}
}
