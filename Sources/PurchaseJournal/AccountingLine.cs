namespace Mc2it.Agicap.PurchaseJournal;

/// <summary>
/// Represents an accounting line of a purchase journal.
/// </summary>
public class AccountingLine {

	/// <summary>
	/// The accounting currency
	/// </summary>
	public string AccountingCurrency { get; set; } = "EUR";

	/// <summary>
	/// The number of the account posted.
	/// </summary>
	public string AccountNumber { get; set; } = "";

	/// <summary>
	/// The type of bookkeeping account.
	/// </summary>
	public AccountingLineAccountType AccountType { get; set; } = AccountingLineAccountType.ExpenseAccount;

	/// <summary>
	/// The analytical codes which are related to the cost bearer.
	/// </summary>
	public IDictionary<string, string> AdditionalAnalyticalCodes { get; set; } = new Dictionary<string, string>();

	/// <summary>
	/// The analytical codes linked to the expense account.
	/// </summary>
	public IDictionary<string, string> AnalyticalCodes { get; set; } = new Dictionary<string, string>();

	/// <summary>
	/// The conversion rate applied to the amounts.
	/// </summary>
	public double ConversionRate { get; set; }

	/// <summary>
	/// The amount applied to the converted credit column.
	/// </summary>
	public decimal ConvertedCreditAmount { get; set; }

	/// <summary>
	/// The amount applied to the converted debit column.
	/// </summary>
	public decimal ConvertedDebitAmount { get; set; }

	/// <summary>
	/// The amount applied to the credit column.
	/// </summary>
	public decimal Credit { get; set; }

	/// <summary>
	/// The currency of the document provided.
	/// </summary>
	public string Currency { get; set; } = "EUR";

	/// <summary>
	/// The amount applied to the debit column.
	/// </summary>
	public decimal Debit { get; set; }

	/// <summary>
	/// The identifier of the line item for invoice accounting purchase typology. Empty for lines of type `SupplierAccount`.
	/// </summary>
	public Guid LineItemId { get; set; } = Guid.Empty;

	/// <summary>
	/// The tax key of vat account if Account Type is `VatAccount else null. Empty for lines of type `VatAccount`.
	/// </summary>
	public string TaxKey { get; set; } = "";

	/// <summary>
	/// The label for the supplier account.
	/// </summary>
	public string ThirdPartyAccount { get; set; } = "";

	/// <summary>
	/// The string "G" for "General".
	/// </summary>
	public string Type { get; set; } = "G";

	/// <summary>
	/// The name of the VAT account (or of the reverse charge for reverse-charge entries). Empty for lines of type `SupplierAccount`.
	/// </summary>
	public string VatAccountName { get; set; } = "";

	/// <summary>
	/// Creates a new accounting line from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The accounting line corresponding to the specified JSON payload.</returns>
	public static explicit operator AccountingLine(PSObject psObject) {
		var json = (dynamic) psObject;
		return new AccountingLine() {
			AccountingCurrency = json.accountingCurrency as string ?? "EUR",
			AccountNumber = json.accountNumber as string ?? "",
			AccountType = Convert.ToEnum<AccountingLineAccountType>(json.accountType, AccountingLineAccountType.ExpenseAccount),
			AdditionalAnalyticalCodes = Convert.ToDictionary<string>(json.additionalAnalyticalCodes),
			AnalyticalCodes = Convert.ToDictionary<string>(json.analyticalCodes),
			ConversionRate = Convert.ToDouble(json.conversionRate),
			ConvertedCreditAmount = Convert.ToDecimal(json.convertedCreditAmount),
			ConvertedDebitAmount = Convert.ToDecimal(json.convertedDebitAmount),
			Credit = Convert.ToDecimal(json.credit),
			Currency = json.currency as string ?? "EUR",
			Debit = Convert.ToDecimal(json.debit),
			LineItemId = json.lineItemId is string lineItemId ? Guid.Parse(lineItemId) : Guid.Empty,
			TaxKey = json.taxKey as string ?? "",
			ThirdPartyAccount = json.thirdPartyAccount as string ?? "",
			Type = json.type as string ?? "G",
			VatAccountName = json.vatAccountName as string ?? ""
		};
	}
}
