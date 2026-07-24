namespace Mc2it.Agicap.Payments;

/// <summary>
/// Represents the bank account of a beneficiary.
/// </summary>
public class BankAccount {

	/// <summary>
	/// The name of the bank the account is located.
	/// </summary>
	public string BankName { get; set; } = "";

	/// <summary>
	/// The bank identifier code of the bank where the account is located.
	/// </summary>
	public string Bic { get; set; } = "";

	/// <summary>
	/// The ISO 3166 alpha-2 code of the country of the bank where the account is located.
	/// </summary>
	public string Country { get; set; } = "";

	/// <summary>
	/// The bank account number (IBAN/BBAN/Other).
	/// </summary>
	public string Identifier { get; set; } = "";

	/// <summary>
	/// Value indicating whether this bank account is empty.
	/// </summary>
	public bool IsEmpty =>
		string.IsNullOrWhiteSpace(BankName) &&
		string.IsNullOrWhiteSpace(Bic) &&
		string.IsNullOrWhiteSpace(Country) &&
		string.IsNullOrWhiteSpace(Identifier) &&
		string.IsNullOrWhiteSpace(IntermediaryBankBic) &&
		string.IsNullOrWhiteSpace(LocalClearingCode);

	/// <summary>
	/// The bank identifier code of the intermediary bank processing the payments.
	/// </summary>
	public string IntermediaryBankBic { get; set; } = "";

	/// <summary>
	/// The local identifier of the bank.
	/// </summary>
	public string LocalClearingCode { get; set; } = "";

	/// <summary>
	/// Creates a new bank account from the specified JSON entity.
	/// </summary>
	/// <param name="psObject">The JSON entity.</param>
	/// <returns>The bank account corresponding to the specified JSON entity.</returns>
	public static explicit operator BankAccount(PSObject psObject) {
		var json = (dynamic) psObject;
		return new BankAccount() {
			BankName = json.bankName is string bankName ? bankName : "",
			Bic = json.bic is string bic ? bic : "",
			Country = json.country is string country ? country : "",
			Identifier = json.identifier is string identifier ? identifier : "",
			IntermediaryBankBic = json.intermediaryBankBic is string intermediaryBankBic ? intermediaryBankBic : "",
			LocalClearingCode = json.localClearingCode is string localClearingCode ? localClearingCode : ""
		};
	}
}
