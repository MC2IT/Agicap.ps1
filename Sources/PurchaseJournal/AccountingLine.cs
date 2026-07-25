namespace Mc2it.Agicap.PurchaseJournal;

using System.Globalization;

/// <summary>
/// Represents an accounting line of a purchase journal.
/// </summary>
public class AccountingLine {

	/// <summary>
	/// The accounting currency
	/// </summary>
	public string AccountingCurrency { get; set; } = RegionInfo.CurrentRegion.ISOCurrencySymbol;

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
	public string Currency { get; set; } = RegionInfo.CurrentRegion.ISOCurrencySymbol;

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
			AccountingCurrency = Convert.ToString(json.accountingCurrency) ?? RegionInfo.CurrentRegion.ISOCurrencySymbol,
			AccountNumber = Convert.ToString(json.accountNumber) ?? "",
			AccountType = Convert.ToEnum<AccountingLineAccountType>(json.accountType) ?? AccountingLineAccountType.ExpenseAccount,
			AdditionalAnalyticalCodes = Convert.ToDictionary<string>(json.additionalAnalyticalCodes),
			AnalyticalCodes = Convert.ToDictionary<string>(json.analyticalCodes),
			ConversionRate = Convert.ToDouble(json.conversionRate) ?? 0,
			ConvertedCreditAmount = Convert.ToDecimal(json.convertedCreditAmount) ?? 0,
			ConvertedDebitAmount = Convert.ToDecimal(json.convertedDebitAmount) ?? 0,
			Credit = Convert.ToDecimal(json.credit) ?? 0,
			Currency = Convert.ToString(json.currency) ?? RegionInfo.CurrentRegion.ISOCurrencySymbol,
			Debit = Convert.ToDecimal(json.debit) ?? 0,
			LineItemId = Convert.ToGuid(json.lineItemId) ?? Guid.Empty,
			TaxKey = Convert.ToString(json.taxKey) ?? "",
			ThirdPartyAccount = Convert.ToString(json.thirdPartyAccount) ?? "",
			Type = Convert.ToString(json.type) ?? "G",
			VatAccountName = Convert.ToString(json.vatAccountName) ?? ""
		};
	}
}
