using System.Text.Json.Serialization;

namespace Mc2it.Agicap.ChartOfAccounts;

/// <summary>
/// Defines the type of an accounting account.
/// </summary>
[JsonConverter(typeof(JsonStringEnumConverter))]
public enum AccountingAccountType {
	Bank,
	Client,
	Expense,
	Other,
	Product,
	Supplier,
	Vat
}
